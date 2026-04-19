-- lua/bookmarks/storage.lua
local S = {}

-- Internal storage: { [list_name] = { {bufnr=, line=} } }
S.bookmarks = { global = {} }
S.active_list = "global"

local function get_list()
  return S.bookmarks[S.active_list]
end

function S.add(bufnr, line)
  table.insert(get_list(), { bufnr = bufnr, line = line })
end

function S.remove(bufnr, line)
  local list = get_list()
  for i, bm in ipairs(list) do
    if bm.bufnr == bufnr and bm.line == line then
      table.remove(list, i)
      break
    end
  end
end

function S.next(bufnr, line)
  local list = get_list()
  for _, bm in ipairs(list) do
    if bm.bufnr == bufnr and bm.line > line then
      return bm
    end
  end
end

function S.prev(bufnr, line)
  local list = get_list()
  for i = #list, 1, -1 do
    local bm = list[i]
    if bm.bufnr == bufnr and bm.line < line then
      return bm
    end
  end
end

function S.get_bookmarks()
  return S.bookmarks
end

function S.get_file_bookmarks(filename)
  local bufnr = vim.fn.bufnr(filename, false)
  if bufnr == -1 then return {} end
  local results = {}
  for _, bm in ipairs(get_list()) do
    if bm.bufnr == bufnr then
      table.insert(results, bm)
    end
  end
  return results
end

return S