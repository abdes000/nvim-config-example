return {
    "zongben/proot.nvim",
    opts = {
        detector = {
            enable_file_detect = true,
            enable_lsp_detect = true,
        },
        files = { ".git" },
        ignore = {
            subpath = true, --If you are using monorepo, set to true to ignore subrepos
            lsp = nil,      -- ignore lsp clients by name e.g. { "pyright", "tsserver" }
        },
        events = {
            entered = function()
                vim.cmd("bufdo bd")

                for _, client in pairs(vim.lsp.get_clients()) do
                    vim.lsp.stop_client(client)
                end
            end
        }
    }
}
