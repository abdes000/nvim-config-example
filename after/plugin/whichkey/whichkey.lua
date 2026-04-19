-- lua/config/whichkey-loader.lua
local M = {}

-- Recursively scan directories for Lua files containing keymaps
local function scan_dir(dir)
    local files = {}
    local handle = vim.loop.fs_scandir(dir)
    if not handle then return files end

    while true do
        local name, t = vim.loop.fs_scandir_next(handle)
        if not name then break end
        local path = dir .. "/" .. name
        if t == "file" and name:match("%.lua$") then
            table.insert(files, path)
        elseif t == "directory" then
            vim.list_extend(files, scan_dir(path))
        end
    end
    return files
end

-- Extract `keys` or `keymaps` tables from each module
local function collect_keymaps()
    local all = {}
    local root = vim.fn.stdpath("config") .. "/lua/plugins" -- adjust to your plugin dir
    local files = scan_dir(root)

    for _, file in ipairs(files) do
        local mod = file:gsub("^" .. vim.fn.stdpath("config") .. "/lua/", ""):gsub("%.lua$", "")
        mod = mod:gsub("/", ".")
        local ok, plugin = pcall(require, mod)
        if ok and type(plugin) == "table" then
            if plugin.keys then
                vim.list_extend(all, plugin.keys)
            elseif plugin.keymaps then
                vim.list_extend(all, plugin.keymaps)
            end
        end
    end
    return all
end

function M.setup()
    local wk = require("which-key")
    local maps = collect_keymaps()

    -- Normalize into which-key format
    local wk_maps = {}
    for _, m in ipairs(maps) do
        if type(m) == "table" then
            local lhs = m[1] or m.lhs
            local rhs = m[2] or m.rhs
            local desc = m.desc or m[3]
            if lhs and rhs then
                wk_maps[lhs] = { rhs, desc }
            end
        end
    end

    wk.register(wk_maps)
end

return M
