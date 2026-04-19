return {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
        ensure_installed = { "python", "node2" }, -- auto-install debuggers
        automatic_installation = true,
        handlers = {},
    },
}
