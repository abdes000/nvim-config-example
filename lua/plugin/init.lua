-- File: lua/plugins/init.lua
-- Aggregator for all plugin specs in lua/plugins/ and its subfolders

local M = {}

-- Root plugins directory
local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"

-- Recursively scan for all Lua files
local files = vim.fn.globpath(plugin_dir, "**/*.lua", false, true)

for _, file in ipairs(files) do
  local rel_path = file:sub(#plugin_dir + 2) -- strip base dir
  local name = rel_path:gsub("%.lua$", ""):gsub("/", ".") -- convert path to module name

  if name ~= "init" then
    local ok, plugin = pcall(require, "plugins." .. name)
    if ok then
      table.insert(M, plugin)
    else
      vim.notify("Error loading plugin: " .. name, vim.log.levels.ERROR)
    end
  end
end

return M
