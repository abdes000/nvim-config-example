return {
    'nvim-lua/lsp-status.nvim',
    config = function()
        local lsp_status = require('lsp-status')
        -- Put this somewhere near lsp_status.register_progress()
        lsp_status.register_progress()
        lsp_status.config({
            indicator_errors = 'E',
            indicator_warnings = 'W',
            indicator_info = 'i',
            indicator_hint = '?',
            indicator_ok = 'Ok',
        })
        local lspconfig = require('lspconfig')

        -- Some arbitrary servers
        lspconfig.clangd.setup({
            handlers = lsp_status.extensions.clangd.setup(),
            init_options = {
                clangdFileStatus = true
            },
            on_attach = lsp_status.on_attach,
            capabilities = lsp_status.capabilities
        })

        lspconfig.pyls_ms.setup({
            handlers = lsp_status.extensions.pyls_ms.setup(),
            settings = { python = { workspaceSymbols = { enabled = true } } },
            on_attach = lsp_status.on_attach,
            capabilities = lsp_status.capabilities
        })

        lspconfig.ghcide.setup({
            on_attach = lsp_status.on_attach,
            capabilities = lsp_status.capabilities
        })
        lspconfig.rust_analyzer.setup({
            on_attach = lsp_status.on_attach,
            capabilities = lsp_status.capabilities
        })
    end
}
