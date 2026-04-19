-- Automatically open dap-ui when debugging starts
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-repl",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, desc = "Close DAP REPL" })
  end,
})

-- Highlight breakpoints
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped",    { text = "▶", texthl = "DiagnosticWarn",  linehl = "Visual", numhl = "" })
  end,
})