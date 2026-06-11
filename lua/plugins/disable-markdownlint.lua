local function strip(list, name)
    if not list then
        return list
    end
    return vim.tbl_filter(function(v)
        return v ~= name
    end, list)
end

return {
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = function(_, opts)
            opts.linters_by_ft = opts.linters_by_ft or {}
            opts.linters_by_ft.markdown = strip(opts.linters_by_ft.markdown, "markdownlint-cli2")
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters_by_ft["markdown"] = strip(opts.formatters_by_ft["markdown"], "markdownlint-cli2")
            opts.formatters_by_ft["markdown.mdx"] = strip(opts.formatters_by_ft["markdown.mdx"], "markdownlint-cli2")
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        opts = function(_, opts)
            if not opts.sources then
                return
            end
            local nls = require("null-ls")
            opts.sources = vim.tbl_filter(function(s)
                return s ~= nls.builtins.diagnostics.markdownlint_cli2
            end, opts.sources)
        end,
    },
    {
        "mason-org/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = strip(opts.ensure_installed, "markdownlint-cli2")
        end,
    },
}
