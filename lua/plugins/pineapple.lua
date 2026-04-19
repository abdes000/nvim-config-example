return {
    "CWood-sdf/pineapple",
    -- opts = {
    --     installedRegistry = "YOUR_LUA_DIRECTORY.pineapple",
    --     colorschemeFile = "after/plugin/theme.lua"
    -- },
    cmd = "Pineapple",
    config = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "PineappleColorschemePost",
            callback = function(ev)
                print("The colorscheme was set to " .. ev.data[1])
            end,
        })
    end
}
