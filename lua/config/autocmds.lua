-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Follow the current Omarchy theme. `lua/plugins/theme.lua` is a symlink to
-- ~/.local/state/omarchy/current/theme/neovim.lua, so lazy.nvim picks the right
-- colorscheme at startup; this watcher applies it live on `omarchy theme set`
-- as well. A theme whose plugin is not installed yet is skipped here and gets
-- applied on the next nvim start, once lazy has fetched it.
local omarchy_state = vim.env.HOME .. "/.local/state/omarchy/current"

local function omarchy_spec()
    local ok, spec = pcall(dofile, omarchy_state .. "/theme/neovim.lua")
    if ok and type(spec) == "table" then return spec end
end

-- Module a theme spec configures, e.g. "bjarneo/aether.nvim" -> "aether".
local function spec_module(entry)
    if entry.name then return entry.name end
    return (entry[1]:match("[^/]+$"):gsub("%.nvim$", ""))
end

local function apply_omarchy_theme()
    local spec = omarchy_spec()
    if type(spec) ~= "table" then return end

    local name
    for _, entry in ipairs(spec) do
        if type(entry) ~= "table" or not entry[1] then goto continue end

        if entry[1] == "LazyVim/LazyVim" then
            name = type(entry.opts) == "table" and entry.opts.colorscheme or name
        elseif type(entry.opts) == "table" then
            -- Themes carry their palette in opts (flavour, generated colors),
            -- which only reach the plugin through its own setup().
            local ok, mod = pcall(require, spec_module(entry))
            if ok and type(mod) == "table" and type(mod.setup) == "function" then
                pcall(mod.setup, entry.opts)
            end
        end

        ::continue::
    end

    if not name then return end
    pcall(vim.cmd.colorscheme, name)
end

vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "background",
    callback = function()
        vim.schedule(apply_omarchy_theme)
    end,
})

-- theme.name is replaced (not rewritten) on a switch, so watch the directory.
local theme_watcher = vim.uv.new_fs_event()
if theme_watcher then
    theme_watcher:start(omarchy_state, {}, function()
        vim.schedule(apply_omarchy_theme)
    end)

    vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
            pcall(function() theme_watcher:stop() end)
        end,
    })
end

vim.api.nvim_create_autocmd("LspAttach", {
    once = true,
    callback = function()
        vim.cmd("Trouble symbols toggle focus=false win.position=right")
    end,
})
