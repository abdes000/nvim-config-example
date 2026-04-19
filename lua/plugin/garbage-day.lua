return {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
        -- your options here
    },
    config = function()
        -- Stop all LSP clients
        vim.keymap.set("n", "<leader>lS", function()
            require("garbage-day.utils").stop_lsp()
        end, opts)

        -- Start LSP clients for the current buffer
        vim.keymap.set("n", "<leader>lR", function()
            require("garbage-day.utils").start_lsp()
        end, opts)
    end
}
