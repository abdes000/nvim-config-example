return {
    'gorbit99/codewindow.nvim',
    opts = {
        active_in_terminals = false,                                                    -- Should the minimap activate for terminal buffers
        auto_enable = false,                                                            -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
        exclude_filetypes = { 'help' },                                                 -- Choose certain filetypes to not show minimap on
        max_minimap_height = nil,                                                       -- The maximum height the minimap can take (including borders)
        max_lines = nil,                                                                -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
        minimap_width = 20,                                                             -- The width of the text part of the minimap
        use_lsp = true,                                                                 -- Use the builtin LSP to show errors and warnings
        use_treesitter = true,                                                          -- Use nvim-treesitter to highlight the code
        use_git = true,                                                                 -- Show small dots to indicate git additions and deletions
        width_multiplier = 4,                                                           -- How many characters one dot represents
        z_index = 1,                                                                    -- The z-index the floating window will be on
        show_cursor = true,                                                             -- Show the cursor position in the minimap
        screen_bounds = 'lines',                                                        -- How the visible area is displayed, "lines": lines above and below, "background": background color
        window_border = 'single',                                                       -- The border style of the floating window (accepts all usual options)
        relative = 'win',                                                               -- What will be the minimap be placed relative to, "win": the current window, "editor": the entire editor
        events = { 'TextChanged', 'InsertLeave', 'DiagnosticChanged', 'FileWritePost' } -- Events that update the code window
    },
    config = function()
        local codewindow = require('codewindow')
        codewindow.setup({
            auto_enable = true,
        })
        -- codewindow.apply_default_keybinds()
        ----------------------------------------------------------------------
        -- Keymaps
        ----------------------------------------------------------------------
        vim.keymap.set("n", "<leader>mo", function()
            codewindow.open_minimap()
        end, { desc = "CodeWindow: Open minimap" })

        vim.keymap.set("n", "<leader>mc", function()
            codewindow.close_minimap()
        end, { desc = "CodeWindow: Close minimap" })

        vim.keymap.set("n", "<leader>mt", function()
            codewindow.toggle_minimap()
        end, { desc = "CodeWindow: Toggle minimap" })

        vim.keymap.set("n", "<leader>mf", function()
            codewindow.toggle_focus()
        end, { desc = "CodeWindow: Toggle minimap focus" })


        -- CodeWindow highlight groups
        vim.api.nvim_set_hl(0, "CodewindowBorder", { fg = "#ffff00" })                      -- border color
        vim.api.nvim_set_hl(0, "CodewindowBackground", { bg = "#1e1e2e" })                  -- minimap background
        vim.api.nvim_set_hl(0, "CodewindowWarn", { fg = "#f9e2af" })                        -- warning dots
        vim.api.nvim_set_hl(0, "CodewindowError", { fg = "#f38ba8" })                       -- error dots
        vim.api.nvim_set_hl(0, "CodewindowAddition", { fg = "#a6e3a1" })                    -- git additions
        vim.api.nvim_set_hl(0, "CodewindowDeletion", { fg = "#f38ba8" })                    -- git deletions
        vim.api.nvim_set_hl(0, "CodewindowUnderline", { underline = true, sp = "#89b4fa" }) -- underlines
        vim.api.nvim_set_hl(0, "CodewindowBoundsBackground", { bg = "#313244" })            -- bounds background



        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                -- reapply CodeWindow highlights after theme change
                vim.api.nvim_set_hl(0, "CodewindowBorder", { fg = "#ffff00" })
                vim.api.nvim_set_hl(0, "CodewindowBackground", { bg = "#1e1e2e" })
                vim.api.nvim_set_hl(0, "CodewindowWarn", { fg = "#f9e2af" })
                vim.api.nvim_set_hl(0, "CodewindowError", { fg = "#f38ba8" })
                vim.api.nvim_set_hl(0, "CodewindowAddition", { fg = "#a6e3a1" })
                vim.api.nvim_set_hl(0, "CodewindowDeletion", { fg = "#f38ba8" })
                vim.api.nvim_set_hl(0, "CodewindowUnderline", { underline = true, sp = "#89b4fa" })
                vim.api.nvim_set_hl(0, "CodewindowBoundsBackground", { bg = "#313244" })
            end,
        })
    end,
}
