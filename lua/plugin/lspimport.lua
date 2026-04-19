return {
    "stevanmilic/nvim-lspimport",
    config = function()
        vim.keymap.set("n", "<leader>li", require("lspimport").import, { noremap = true })
        -- LSP Import keymap (works across all servers that support it)
        local opts = { noremap = true, silent = true }

        -- If your server supports `vim.lsp.buf.import()` directly:
        vim.keymap.set("n", "<leader>li", function()
            vim.lsp.buf.import()
        end, opts)
        -- Otherwise, fallback to code actions (many servers expose "Add Import" here):
        vim.keymap.set("n", "<leader>la", function()
            vim.lsp.buf.code_action({
                context = { only = { "source.addImport" } }
            })
        end, opts)

    end
}
