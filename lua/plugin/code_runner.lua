return {
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        -- Filetype-specific commands
        filetype = {
            python = "python3 -u",
            javascript = "node",
            typescript = "ts-node",
            lua = "lua",
            go = "go run",
            rust = "cargo run",
            c = "gcc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
            cpp = "g++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
            sh = "bash",
        },
        -- Default command for any other language/filetype
        default = "echo 'No specific runner configured for this filetype';",
        mode = "toggleterm", -- "toggleterm" | "term" | "float"
        startinsert = true,
        focus = true,
    },
    config = function(_, opts)
        require("code_runner").setup(opts)
        vim.keymap.set('n', '<leader>rr', ':RunCode<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })
        -- Automatically run code on save for all filetypes
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*",
            callback = function()
                vim.cmd("RunCode")
            end,
        })
        require("code_runner").setup({
            mode = "toggleterm",
            startinsert = true,
        })
        vim.keymap.set("n", "<leader>rT", "<cmd>Telescope run<cr>", { desc = "CodeRunner: Telescope run picker" })
        vim.keymap.set("n", "<leader>rd", function()
            require("dap").continue()
        end, { desc = "CodeRunner: Run with DAP" })
        -- Notify when runner starts
        vim.api.nvim_create_autocmd("User", {
            pattern = "CodeRunnerRun",
            callback = function()
                print("CodeRunner: Execution started...")
            end,
        })

        -- Notify when runner closes
        vim.api.nvim_create_autocmd("User", {
            pattern = "CodeRunnerClose",
            callback = function()
                print("CodeRunner: Execution finished.")
            end,
        })
    end,
}
