return {
    'nvimdev/lspsaga.nvim',
    config = function()
        -- Global keymaps for lspsaga call hierarchy
        local keymap = vim.keymap.set
        local saga = require('lspsaga')
        local builtin = require('telescope.builtin')

        -- Show incoming calls
        keymap("n", "<leader>ci", function()
            saga.callhierarchy.incoming()
        end, { desc = "Lspsaga Incoming Calls" })

        -- Show outgoing calls
        keymap("n", "<leader>co", function()
            saga.callhierarchy.outgoing()
        end, { desc = "Lspsaga Outgoing Calls" })

        -- You can also map other saga features if you like:
        keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Lspsaga Code Action" })
        keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Lspsaga Rename" })
        keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Lspsaga Hover Doc" })

        -- Diagnostics
        keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line Diagnostics" })
        keymap("n", "<leader>cb", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "Buffer Diagnostics" })
        keymap("n", "<leader>cw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", { desc = "Workspace Diagnostics" })
        keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })
        keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })

        -- Code actions & refactor
        keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
        keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { desc = "Range Code Action" })
        keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename Symbol" })

        -- Hover & docs
        keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Documentation" })
        keymap("n", "<leader>kk", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
        keymap("n", "<leader>kt", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "Peek Type Definition" })

        -- Finder (references/definitions)
        keymap("n", "<leader>fr", "<cmd>Lspsaga finder<CR>", { desc = "Finder (Refs/Defs)" })

        -- Call hierarchy
        keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", { desc = "Incoming Calls" })
        keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "Outgoing Calls" })

        -- Outline (symbols tree)
        keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "Symbols Outline" })

        -- Terminal integration
        keymap("n", "<leader>tt", "<cmd>Lspsaga term_toggle<CR>", { desc = "Toggle Terminal" })

        -- Telescope LSP pickers
        keymap("n", "<leader>gr", builtin.lsp_references, { desc = "Telescope References" })
        keymap("n", "<leader>gd", builtin.lsp_definitions, { desc = "Telescope Definitions" })
        keymap("n", "<leader>gt", builtin.lsp_type_definitions, { desc = "Telescope Type Definitions" })
        keymap("n", "<leader>gi", builtin.lsp_implementations, { desc = "Telescope Implementations" })
        keymap("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "Telescope Document Symbols" })
        keymap("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, { desc = "Telescope Workspace Symbols" })

        -- Telescope diagnostics
        keymap("n", "<leader>dd", builtin.diagnostics, { desc = "Telescope Diagnostics" })

        -- Combine with lspsaga
        keymap("n", "<leader>fr", "<cmd>Lspsaga finder<CR>", { desc = "Saga Finder" })
        keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", { desc = "Saga Incoming Calls" })
        keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "Saga Outgoing Calls" })


        -- Smart references
        keymap("n", "<leader>sr", function()
            local params = vim.lsp.util.make_position_params()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                -- Try Saga finder if LSP is attached
                saga.finder()
            else
                -- Fallback to Telescope references
                builtin.lsp_references()
            end
        end, { desc = "Smart References (Saga/Telescope)" })

        -- Smart definitions
        keymap("n", "<leader>sd", function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                saga.peek_definition()
            else
                builtin.lsp_definitions()
            end
        end, { desc = "Smart Definitions (Saga/Telescope)" })

        -- Smart symbols
        keymap("n", "<leader>ss", function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                saga.outline()
            else
                builtin.lsp_document_symbols()
            end
        end, { desc = "Smart Symbols (Saga/Telescope)" })

        -- Smart diagnostics
        keymap("n", "<leader>sdx", function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                -- Saga workspace diagnostics (structured UI)
                vim.cmd("Lspsaga show_workspace_diagnostics")
            else
                -- Telescope diagnostics (fuzzy search)
                builtin.diagnostics()
            end
        end, { desc = "Smart Diagnostics (Saga/Telescope)" })

        -- Smart incoming calls
        keymap("n", "<leader>sci", function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                saga.callhierarchy.incoming()
            else
                builtin.lsp_references() -- fallback: references as closest equivalent
            end
        end, { desc = "Smart Incoming Calls (Saga/Telescope)" })

        -- Smart outgoing calls
        keymap("n", "<leader>sco", function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                saga.callhierarchy.outgoing()
            else
                builtin.lsp_references()
            end
        end, { desc = "Smart Outgoing Calls (Saga/Telescope)" })

        -- Smart diagnostics (workspace-level)
        keymap("n", "<leader>sdx", function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                vim.cmd("Lspsaga show_workspace_diagnostics")
            else
                builtin.diagnostics()
            end
        end, { desc = "Smart Diagnostics (Saga/Telescope)" })

        -- Smart line diagnostics
        keymap("n", "<leader>sdl", function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                vim.cmd("Lspsaga show_line_diagnostics")
            else
                builtin.diagnostics({ bufnr = 0 })
            end
        end, { desc = "Smart Line Diagnostics (Saga/Telescope)" })

        -- Smart buffer diagnostics
        keymap("n", "<leader>sdb", function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                vim.cmd("Lspsaga show_buf_diagnostics")
            else
                builtin.diagnostics({ bufnr = 0 })
            end
        end, { desc = "Smart Buffer Diagnostics (Saga/Telescope)" })

        -- Smart incoming calls
        keymap("n", "<leader>sci", function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                saga.callhierarchy.incoming()
            else
                builtin.lsp_references()
            end
        end, { desc = "Smart Incoming Calls (Saga/Telescope)" })

        -- Smart outgoing calls
        keymap("n", "<leader>sco", function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                saga.callhierarchy.outgoing()
            else
                builtin.lsp_references()
            end
        end, { desc = "Smart Outgoing Calls (Saga/Telescope)" })

        -- Jump to implementation
        keymap("n", "<leader>gi", "<cmd>Lspsaga goto_implementation<CR>", { desc = "Goto Implementation" })

        -- Peek implementation (like peek definition)
        keymap("n", "<leader>pi", "<cmd>Lspsaga peek_implementation<CR>", { desc = "Peek Implementation" })

        -- Toggle implement signs/virtual text (if you want control)
        keymap("n", "<leader>ti", function()
            local saga_impl = require("lspsaga.implement")
            saga_impl.toggle_virtual_text()
        end, { desc = "Toggle Implementation Virtual Text" })

        -- Toggle outline window
        keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "Toggle Outline" })

        -- Jump to symbol (explicit jump)
        keymap("n", "<leader>oe", function()
            vim.cmd("Lspsaga outline")
            vim.api.nvim_feedkeys("e", "n", false) -- simulate pressing 'e' inside outline
        end, { desc = "Jump to Symbol from Outline" })

        -- Toggle expand/collapse or jump
        keymap("n", "<leader>oo", function()
            vim.cmd("Lspsaga outline")
            vim.api.nvim_feedkeys("o", "n", false) -- simulate pressing 'o' inside outline
        end, { desc = "Toggle/Jump in Outline" })

        -- Quit outline window
        keymap("n", "<leader>oq", function()
            vim.cmd("Lspsaga outline")
            vim.api.nvim_feedkeys("q", "n", false) -- simulate pressing 'q' inside outline
        end, { desc = "Quit Outline Window" })
        -- Trigger rename (default float window)
        keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename Symbol" })

        -- Trigger rename in normal mode (no in_select)
        keymap("n", "<leader>rN", "<cmd>Lspsaga rename mode=n<CR>", { desc = "Rename Symbol (Normal Mode)" })

        -- Project-wide rename
        keymap("n", "<leader>rp", "<cmd>Lspsaga project_replace<CR>", { desc = "Project Replace" })

        vim.keymap.set({ 'n', 't', '<A-d>', '<cmd>Lspsaga term_toggle' })
        vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc')
        require('lspsaga').setup({
            callhierarchy = {
                keys = {
                    edit = 'e',          -- open file
                    vsplit = 's',        -- open in vertical split
                    split = 'i',         -- open in horizontal split
                    tabe = 't',          -- open in new tab
                    quit = 'q',          -- quit layout
                    shuttle = '[w',      -- move between left/right layout
                    toggle_or_req = 'u', -- toggle or request
                    close = '<C-c>k',    -- close layout
                },
            },

            diagnostic = {
                show_code_action = true,           -- show code action in diagnostic jump window
                jump_num_shortcut = true,          -- enable number shortcuts for quick actions
                max_width = 0.8,                   -- max width of diagnostic jump window
                max_height = 0.6,                  -- max height of diagnostic jump window
                text_hl_follow = true,             -- text highlight follows diagnostic type
                border_follow = true,              -- border color follows diagnostic type
                extend_relatedInformation = false, -- extend message if relatedInformation exists
                show_layout = 'float',             -- layout type: 'float' or 'normal'
                show_normal_height = 10,           -- height when layout is normal
                max_show_width = 0.9,              -- max width when layout is float
                max_show_height = 0.6,             -- max height when layout is float
                diagnostic_only_current = false,   -- only show virtual text on current line
            },
            -- finder = {
            --     max_height = 0.6,
            --     keys = {
            --         vsplit = 'v',
            --     },
            --      methods = {
            --         tyd = 'textDocument/typeDefinition'
            --     },
            -- },
            finder = {
                max_height = 0.5,    -- max height of finder window (float layout)
                left_width = 0.3,    -- width of left finder window
                right_width = 0.3,   -- width of right finder window
                default = 'ref+imp', -- default search results: references + implementations
                methods = {
                    -- Example: add type definition
                    tyd = 'textDocument/typeDefinition',
                },
                layout = 'float',         -- layout: 'float' or 'normal'
                filter = {},              -- custom filters per LSP method
                silent = false,           -- show "no response" message if true
                keys = {
                    shuttle = '[w',       -- move between left/right finder windows
                    toggle_or_open = 'o', -- toggle expand or open
                    vsplit = 's',         -- open in vertical split
                    split = 'i',          -- open in horizontal split
                    tabe = 't',           -- open in new tab
                    tabnew = 'r',         -- open in new tab (alternative)
                    quit = 'q',           -- quit finder (left window only)
                    close = '<C-c>k',     -- close finder
                },
            },
            hover = {
                max_width = 0.9,      -- float window width
                max_height = 0.8,     -- float window height
                open_link = 'gx',     -- keybinding to open links
                open_cmd = '!chrome', -- command used to open links
            },
            implement = {
                enable = true,       -- enable the implement feature
                sign = true,         -- show sign in the status column
                virtual_text = true, -- show virtual text at the end of line
                priority = 100,      -- sign priority
            },
            symbols_in_winbar = {
                enable = true, -- must be enabled for implement module to work
            },
            diagnostic = {
                enable = true,       -- enable diagnostic signs/virtual text
                sign = true,         -- show sign in the status column
                virtual_text = true, -- show virtual text at the end of line
                debounce = 10,       -- debounce time for updates (ms)
                sign_priority = 40,  -- priority of diagnostic signs
            },
            outline = {
                win_position = 'right',   -- position of outline window
                win_width = 30,           -- width of outline window
                auto_preview = true,      -- auto preview when cursor moves in outline
                detail = true,            -- show detail info
                auto_close = true,        -- auto close if outline is last window
                close_after_jump = false, -- keep outline open after jump
                layout = 'normal',        -- 'normal' or 'float' layout
                max_height = 0.5,         -- height of outline float layout
                left_width = 0.3,         -- width of left window in float layout
                keys = {
                    toggle_or_jump = 'o', -- toggle expand/collapse or jump
                    quit = 'q',           -- quit outline window
                    jump = 'e',           -- jump even on expand/collapse node
                },
            },
            symbols_in_winbar = {
                enable = true, -- must be enabled for outline to work
            },
            rename = {
                in_select = true,         -- select the current name when float opens
                auto_save = false,        -- auto save file after rename
                project_max_width = 0.5,  -- width of project_replace float window
                project_max_height = 0.5, -- height of project_replace float window
                keys = {
                    quit = '<C-k>',       -- quit rename/project_replace window
                    exec = '<CR>',        -- execute rename or project replace
                    select = 'x',         -- select/cancel item in project_replace window
                },
            },
            ui = {
                border = 'single', -- border style for float windows
                devicon = true, -- use nvim-web-devicons
                title = true, -- show title in float windows
                expand = '⊞', -- expand icon
                collapse = '⊟', -- collapse icon
                code_action = '💡', -- code action icon
                actionfix = ' ', -- action fix icon
                lines = { '┗', '┣', '┃', '━', '┏' }, -- virtual text connector symbols
                kind = {}, -- custom LSP kind icons (optional)
                imp_sign = ' ', -- implement icon
            },
            beacon = {
                enable = true, -- enable beacon effect
                frequency = 7, -- beacon frequency (cursor jump indicator)
            },
            scroll_preview = {
                scroll_down = '<C-f>', -- scroll down in preview window
                scroll_up = '<C-b>', -- scroll up in preview window
            },

        })
        require('lspsaga.symbol.winbar').get_bar()
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
}
