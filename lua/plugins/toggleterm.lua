return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            -- Size of terminal windows
            size = 15,
            -- Open terminals in floating mode by default
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float", -- "horizontal" | "vertical" | "tab" | "float"
            close_on_exit = true,
            shell = vim.o.shell,
            auto_scroll = true,
        })
        -- Normal mode mappings
        vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "ToggleTerm: Horizontal" })
        vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "ToggleTerm: Vertical" })
        vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm: Float" })
        vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", { desc = "ToggleTerm: Tab" })

        -- Terminal mode mappings
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "ToggleTerm: Exit terminal mode" })
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "ToggleTerm: Move left" })
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "ToggleTerm: Move down" })
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "ToggleTerm: Move up" })
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "ToggleTerm: Move right" })

        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

        vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { desc = "ToggleTerm: LazyGit" })

        local python = Terminal:new({ cmd = "python", hidden = true })
        vim.keymap.set("n", "<leader>tp", function() python:toggle() end, { desc = "ToggleTerm: Python REPL" })

        local node = Terminal:new({ cmd = "node", hidden = true })
        vim.keymap.set("n", "<leader>tn", function() node:toggle() end, { desc = "ToggleTerm: Node REPL" })

        vim.keymap.set("n", "<leader>tr", function()
            local file = vim.fn.expand("%")
            require("toggleterm.terminal").Terminal:new({ cmd = "python " .. file, hidden = true }):toggle()
        end, { desc = "ToggleTerm: Run current file in Python" })
    end,
}
