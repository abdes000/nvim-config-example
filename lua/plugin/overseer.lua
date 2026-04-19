return {
    'stevearc/overseer.nvim',
    opts = {
      strategy = "toggleterm",   -- run tasks inside toggleterm
      templates = { "builtin" }, -- use built-in templates for many languages
        task_list = {
          direction = "bottom",
            min_height = 25,
            max_height = 25,
            default_detail = 1,
          },
          -- Default runner for all languages
        default_template = {
          cmd = { "echo", "No template found for this filetype" },
        },
      },
      config = function(_, opts)
        require("overseer").setup(opts)
        ---@module 'overseer'
        ---@type overseer.SetupOpts
        -- Task management
        vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<cr>", { desc = "Overseer: Toggle task list" })
        vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", { desc = "Overseer: Run task" })
        vim.keymap.set("n", "<leader>oq", "<cmd>OverseerQuickAction<cr>", { desc = "Overseer: Quick action" })
        vim.keymap.set("n", "<leader>oa", "<cmd>OverseerTaskAction<cr>", { desc = "Overseer: Task action" })
        vim.keymap.set("n", "<leader>ol", "<cmd>OverseerLoadBundle<cr>", { desc = "Overseer: Load bundle" })
        vim.keymap.set("n", "<leader>os", "<cmd>OverseerSaveBundle<cr>", { desc = "Overseer: Save bundle" })
        vim.keymap.set("n", "<leader>oc", "<cmd>OverseerClear<cr>", { desc = "Overseer: Clear tasks" })

        -- Automatically run code on save for all filetypes
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*",
            callback = function()
                require("overseer").run_template({ name = vim.bo.filetype })
            end,
        })

        -- Automatically open task list when a task starts
        vim.api.nvim_create_autocmd("User", {
            pattern = "OverseerTaskStarted",
            callback = function()
                vim.cmd("OverseerOpen")
            end,
        })

        require("overseer").setup({
            strategy = "toggleterm",
        })

        vim.keymap.set("n", "<leader>oT", "<cmd>Telescope overseer<cr>", { desc = "Overseer: Telescope task picker" })

        local dap = require("dap")
        dap.listeners.before.launch["overseer_integration"] = function(_, config)
            require("overseer").run_template({ name = "build" })
        end

        -- Notify when task starts
        vim.api.nvim_create_autocmd("User", {
            pattern = "OverseerTaskStarted",
            callback = function()
                print("Overseer: Task started...")
            end,
        })

        -- Notify when task completes
        vim.api.nvim_create_autocmd("User", {
            pattern = "OverseerTaskCompleted",
            callback = function()
                print("Overseer: Task completed!")
            end,
        })
    end,
}
