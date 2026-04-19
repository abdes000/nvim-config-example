-- Core debugging
vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", require("dap").continue, { desc = "DAP: Continue" })
vim.keymap.set("n", "<leader>dn", require("dap").step_over, { desc = "DAP: Step over" })
vim.keymap.set("n", "<leader>di", require("dap").step_into, { desc = "DAP: Step into" })
vim.keymap.set("n", "<leader>do", require("dap").step_out, { desc = "DAP: Step out" })
vim.keymap.set("n", "<leader>dr", require("dap").repl.open, { desc = "DAP: Open REPL" })
vim.keymap.set("n", "<leader>dl", require("dap").run_last, { desc = "DAP: Run last" })

-- UI
vim.keymap.set("n", "<leader>du", require("dapui").toggle, { desc = "DAP: Toggle UI" })

-- Virtual text toggle
vim.keymap.set("n", "<leader>dv", function()
    require("nvim-dap-virtual-text").toggle()
end, { desc = "DAP: Toggle virtual text" })
