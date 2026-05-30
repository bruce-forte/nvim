return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
        opts.window = opts.window or {}
        opts.window.width = math.floor(vim.o.columns * 0.2)
        return opts
    end,
}
