-- lua/bookmarks/init.lua
local M = {}
local storage = require("storage")

-- Add bookmark at current line
function M.add_bookmark()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  storage.add(bufnr, line)
end

-- Remove bookmark at current line
function M.remove_bookmark()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  storage.remove(bufnr, line)
end

-- Jump to next bookmark in current buffer
function M.jump_to_next()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local next = storage.next(bufnr, line)
  if next then
    vim.api.nvim_win_set_cursor(0, { next.line, 0 })
  end
end

-- Jump to previous bookmark in current buffer
function M.jump_to_prev()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local prev = storage.prev(bufnr, line)
  if prev then
    vim.api.nvim_win_set_cursor(0, { prev.line, 0 })
  end
end

-- Jump to a specific bookmark
function M.jump_to_bookmark(filename, line_number)
  local bufnr = vim.fn.bufnr(filename, true)
  if bufnr ~= -1 then
    vim.api.nvim_set_current_buf(bufnr)
    vim.api.nvim_win_set_cursor(0, { line_number, 0 })
  end
end

return M
