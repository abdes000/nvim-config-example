return {
    "OscarCreator/rsync.nvim",
    build = "make",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        require("rsync").setup()
        local opts = {noremap = true, silent = true}
        local keys = {
            {"<leader>rd", ":RsyncDown<CR>", desc = "Sync all files from remote → local"},
            {"<leader>rf", ":RsyncDownFile<CR>", desc = "Sync current/specified file from remote → local"},
            {"<leader>ru", ":RsyncUp<CR>", desc = "Sync all files from local → remote"},
            {"<leader>rU", ":RsyncUpFile<CR>", desc = "Sync current/specified file from local → remote"},
            {"<leader>rl", ":RsyncLog<CR>", desc = "Open rsync.nvim log file"},
            {"<leader>rc", ":RsyncConfig<CR>", desc = "Print user config"},
            {"<leader>rp", ":RsyncProjectConfig<CR>", desc = "Print/reload project config"},
            {"<leader>rs", ":RsyncSaveSync<CR>", desc = "Toggle sync on save"}
        }
        for _, key in ipairs(keys) do
            vim.keymap.set("n", key[1], key[2], opts)
        end
    end,
    ---@type RsyncConfig
    opts = {
        -- triggers `RsyncUp` when fugitive thinks something might have changed in the repo.
        fugitive_sync = false,
        -- triggers `RsyncUp` when you save a file.
        sync_on_save = true,
        -- the path to the project configuration
        project_config_path = ".nvim/rsync.toml",
        -- called when the rsync command exits, provides the exit code and the used command
        on_exit = function(code, command)
        end,
        -- called when the rsync command prints to stderr, provides the data and the used command
        on_stderr = function(data, command)
        end
    }
}
