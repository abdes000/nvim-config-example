return {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    opts = {
        autoEnableHints = true,
        icons = {
            type = "󰜁 ",
            parameter = "󰏪 ",
            offspec = " ", -- hint kind not defined in official LSP spec
            unknown = " ", -- hint kind is nil
        },
        label = {
            truncateAtChars = 20,
            padding = 1,
            marginLeft = 0,
            sameKindSeparator = ", ",
        },
        extmark = {
            priority = 50,
        },

        ---Function that overrides how hints are displayed.
        ---expects as output a table for `virt_text` from `nvim_buf_set_extmark`,
        ---that is a table of string tuples (text & highlight group)
        ---To use filetype-specific formatting, get the filetype via
        ---`vim.bo[bufnr].filetype`, to conditionally use the default formatting
        ---function, use `defaultHintFormatFunc(hints)`.
        ---@type function(hints: {label: string, col: number, kind: string}[], bufnr: number, defaultHintFormatFunc: func): {[1]: string, [2]: string}[]
        hintFormatFunc = nil,
    }, -- required, even if empty
    config = function()
        -- LSP Endhints keymaps
        local opts = { noremap = true, silent = true }
        -- lsp-endhints setup for all LSPs
        local lsp_endhints = require("lsp-endhints")

        -- Global keymaps for controlling hints
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>he", function() lsp_endhints.enable() end, opts)  -- Enable
        vim.keymap.set("n", "<leader>hd", function() lsp_endhints.disable() end, opts) -- Disable
        vim.keymap.set("n", "<leader>ht", function() lsp_endhints.toggle() end, opts)  -- Toggle
    end
}
