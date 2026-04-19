-- lua/bookmarks/telescope.lua
local storage = require("storage")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

-- Bookmarks picker
function M.bookmarks_picker()
  local list = storage.get_bookmarks()[storage.active_list] or {}
  pickers.new({}, {
    prompt_title = "Bookmarks (" .. storage.active_list .. ")",
    finder = finders.new_table {
      results = list,
      entry_maker = function(entry)
        local filename = vim.api.nvim_buf_get_name(entry.bufnr)
        return {
          value = entry,
          display = filename .. ":" .. entry.line,
          ordinal = filename .. ":" .. entry.line,
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      -- Jump to bookmark
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        vim.api.nvim_set_current_buf(selection.value.bufnr)
        vim.api.nvim_win_set_cursor(0, { selection.value.line, 0 })
        actions.close(prompt_bufnr)
      end)
      -- Delete bookmark
      map("i", "<Del>", function()
        local selection = action_state.get_selected_entry()
        storage.remove(selection.value.bufnr, selection.value.line)
        actions.close(prompt_bufnr)
      end)
      return true
    end,
  }):find()
end

-- Lists picker
function M.lists_picker()
  local names = vim.tbl_keys(storage.get_bookmarks())
  pickers.new({}, {
    prompt_title = "Bookmark Lists",
    finder = finders.new_table { results = names },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      -- Switch to list
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        storage.active_list = selection.value
        actions.close(prompt_bufnr)
      end)
      -- Create new list
      map("i", "<C-n>", function()
        local name = vim.fn.input("New list name: ")
        if name ~= "" then storage.bookmarks[name] = {} end
      end)
      -- Rename list
      map("i", "<C-r>", function()
        local old = action_state.get_selected_entry().value
        local new = vim.fn.input("Rename to: ")
        if new ~= "" then
          storage.bookmarks[new] = storage.bookmarks[old]
          storage.bookmarks[old] = nil
          if storage.active_list == old then storage.active_list = new end
        end
      end)
      -- Delete list
      map("i", "<C-d>", function()
        local name = action_state.get_selected_entry().value
        if name ~= "global" then
          for _, bm in ipairs(storage.bookmarks[name]) do
            table.insert(storage.bookmarks.global, bm)
          end
          storage.bookmarks[name] = nil
          if storage.active_list == name then storage.active_list = "global" end
        end
      end)
      return true
    end,
  }):find()
end

return M
