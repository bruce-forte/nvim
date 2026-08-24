-- Every colorscheme plugin any Omarchy theme can ask for, kept installed but
-- lazy so `omarchy theme set` can switch a running nvim without a restart.
-- The active theme's own spec (opts, flavour, generated palette) comes from
-- lua/plugins/theme.lua, which symlinks the current theme's neovim.lua.
local function theme(spec)
    spec.lazy = true
    spec.priority = 1000
    return spec
end

return {
    theme({ "bjarneo/aether.nvim", branch = "v3", name = "aether" }),
    theme({ "bjarneo/hackerman.nvim" }),
    theme({ "catppuccin/nvim", name = "catppuccin" }),
    theme({ "EdenEast/nightfox.nvim" }),
    theme({ "ellisonleao/gruvbox.nvim" }),
    theme({ "ficcdaf/ashen.nvim" }),
    theme({ "folke/tokyonight.nvim" }),
    theme({ "kepano/flexoki-neovim" }),
    theme({ "neanias/everforest-nvim" }),
    theme({ "OldJobobo/retro-82.nvim" }),
    theme({ "omacom-io/lumon.nvim" }),
    theme({ "rebelot/kanagawa.nvim" }),
    theme({ "ribru17/bamboo.nvim" }),
    theme({ "rose-pine/neovim", name = "rose-pine" }),
    theme({ "tahayvr/matteblack.nvim" }),
}
