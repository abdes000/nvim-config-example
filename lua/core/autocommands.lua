
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General group
local general = augroup("General", { clear = true })

-- Highlight yanked text
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

-- Automatically reload file if changed externally
autocmd({ "FocusGained", "BufEnter" }, {
  group = general,
  command = "checktime",
})

-- Restore cursor position when reopening file
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

-- Close certain filetypes with <q>
autocmd("FileType", {
  group = general,
  pattern = { "help", "man", "qf", "lspinfo", "checkhealth" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
  end,
})

-- Trim trailing whitespace on save
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Auto create missing directories before saving
autocmd("BufWritePre", {
  group = general,
  callback = function(event)
    local dir = vim.fn.fnamemodify(event.match, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Resize splits when window is resized
autocmd("VimResized", {
  group = general,
  command = "tabdo wincmd =",
})

-- Set spell checking for markdown and text files
autocmd("FileType", {
  group = general,
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
  end,
})

-- Enable wrap and linebreak for markdown
autocmd("FileType", {
  group = general,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

-- Auto toggle relative number depending on mode
autocmd("InsertEnter", {
  group = general,
  callback = function()
    vim.opt.relativenumber = false
  end,
})
autocmd("InsertLeave", {
  group = general,
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Highlight TODO, FIXME, NOTE in code
autocmd("Syntax", {
  group = general,
  pattern = "*",
  callback = function()
    vim.cmd [[syntax match Todo /\v<(TODO|FIXME|NOTE):?/]]
  end,
})
