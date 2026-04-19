return {
    "heilgar/bookmarks.nvim",
    dependencies = {
        "kkharji/sqlite.lua",
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- bookmarks.lua
        -- Minimal bookmark manager with Telescope integration

        local M = {}

        -- Internal state
        M.bookmarks = {}
        M.lists = { global = {} }
        M.active_list = "global"
        M.branch_scope = false

        -- Helpers
        local function current_buf_line()
            local bufnr = vim.api.nvim_get_current_buf()
            local line = vim.api.nvim_win_get_cursor(0)[1]
            return { bufnr = bufnr, line = line }
        end

        local function get_active_list()
            return M.lists[M.active_list]
        end

        -- Commands
        vim.api.nvim_create_user_command("BookmarkAdd", function()
            table.insert(get_active_list(), current_buf_line())
        end, {})

        vim.api.nvim_create_user_command("BookmarkRemove", function()
            local cur = current_buf_line()
            local list = get_active_list()
            for i, bm in ipairs(list) do
                if bm.bufnr == cur.bufnr and bm.line == cur.line then
                    table.remove(list, i)
                    break
                end
            end
        end, {})

        vim.api.nvim_create_user_command("Bookmarks", function()
            require("lua.plugins.telescope.telescope").extensions.bookmarks.bookmarks()
        end, {})

        vim.api.nvim_create_user_command("BookmarksToggleBranchScope", function()
            M.branch_scope = not M.branch_scope
            print("Branch scope: " .. tostring(M.branch_scope))
        end, {})

        -- List management
        vim.api.nvim_create_user_command("BookmarkListCreate", function(opts)
            local name = opts.args
            if not M.lists[name] then M.lists[name] = {} end
        end, { nargs = 1 })

        vim.api.nvim_create_user_command("BookmarkListSwitch", function(opts)
            local name = opts.args
            if name == "global" or M.lists[name] then
                M.active_list = name
            else
                print("No such list: " .. name)
            end
        end, { nargs = 1 })

        vim.api.nvim_create_user_command("BookmarkListRename", function(opts)
            local old, new = unpack(vim.split(opts.args, " "))
            if M.lists[old] then
                M.lists[new] = M.lists[old]
                M.lists[old] = nil
                if M.active_list == old then M.active_list = new end
            end
        end, { nargs = 2 })

        vim.api.nvim_create_user_command("BookmarkListDelete", function(opts)
            local name = opts.args
            if M.lists[name] then
                for _, bm in ipairs(M.lists[name]) do
                    table.insert(M.lists.global, bm)
                end
                M.lists[name] = nil
                if M.active_list == name then M.active_list = "global" end
            end
        end, { nargs = 1 })

        vim.api.nvim_create_user_command("BookmarkListShow", function()
            for name, _ in pairs(M.lists) do
                local marker = (name == M.active_list) and "*" or " "
                print(marker .. " " .. name)
            end
        end, {})

        -- Telescope integration
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        require("lua.plugins.telescope.telescope").extensions.bookmarks = {
            bookmarks = function()
                local list = get_active_list()
                pickers.new({}, {
                    prompt_title = "Bookmarks (" .. M.active_list .. ")",
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
                        actions.select_default:replace(function()
                            local selection = action_state.get_selected_entry()
                            vim.api.nvim_set_current_buf(selection.value.bufnr)
                            vim.api.nvim_win_set_cursor(0, { selection.value.line, 0 })
                            actions.close(prompt_bufnr)
                        end)
                        map("i", "<Del>", function()
                            local selection = action_state.get_selected_entry()
                            for i, bm in ipairs(get_active_list()) do
                                if bm == selection.value then
                                    table.remove(get_active_list(), i)
                                    break
                                end
                            end
                            actions.close(prompt_bufnr)
                        end)
                        return true
                    end,
                }):find()
            end,

            lists = function()
                local names = vim.tbl_keys(M.lists)
                pickers.new({}, {
                    prompt_title = "Bookmark Lists",
                    finder = finders.new_table { results = names },
                    sorter = conf.generic_sorter({}),
                    attach_mappings = function(prompt_bufnr, map)
                        actions.select_default:replace(function()
                            local selection = action_state.get_selected_entry()
                            M.active_list = selection.value
                            actions.close(prompt_bufnr)
                        end)
                        map("i", "<C-n>", function()
                            local name = vim.fn.input("New list name: ")
                            if name ~= "" then M.lists[name] = {} end
                        end)
                        map("i", "<C-r>", function()
                            local old = action_state.get_selected_entry().value
                            local new = vim.fn.input("Rename to: ")
                            if new ~= "" then
                                M.lists[new] = M.lists[old]
                                M.lists[old] = nil
                                if M.active_list == old then M.active_list = new end
                            end
                        end)
                        map("i", "<C-d>", function()
                            local name = action_state.get_selected_entry().value
                            if name ~= "global" then
                                for _, bm in ipairs(M.lists[name]) do
                                    table.insert(M.lists.global, bm)
                                end
                                M.lists[name] = nil
                                if M.active_list == name then M.active_list = "global" end
                            end
                        end)
                        return true
                    end,
                }):find()
            end,
        }

        -- Keymaps
        vim.keymap.set("n", "<leader>ba", ":BookmarkAdd<CR>", { desc = "Add bookmark" })
        vim.keymap.set("n", "<leader>br", ":BookmarkRemove<CR>", { desc = "Remove bookmark" })
        vim.keymap.set("n", "<leader>bj", function()
            local cur = current_buf_line()
            local list = get_active_list()
            for _, bm in ipairs(list) do
                if bm.bufnr == cur.bufnr and bm.line > cur.line then
                    vim.api.nvim_win_set_cursor(0, { bm.line, 0 })
                    return
                end
            end
        end, { desc = "Next bookmark" })

        vim.keymap.set("n", "<leader>bk", function()
            local cur = current_buf_line()
            local list = get_active_list()
            for i = #list, 1, -1 do
                local bm = list[i]
                if bm.bufnr == cur.bufnr and bm.line < cur.line then
                    vim.api.nvim_win_set_cursor(0, { bm.line, 0 })
                    return
                end
            end
        end, { desc = "Prev bookmark" })

        vim.keymap.set("n", "<leader>bl", ":Bookmarks<CR>", { desc = "List bookmarks" })
        vim.keymap.set("n", "<leader>bs", ":Telescope bookmarks lists<CR>", { desc = "Switch bookmark list" })


        require("bookmarks").setup({
            -- your configuration comes here
            -- or leave empty to use defaults
            default_mappings = true,
            db_path = vim.fn.stdpath('data') .. '/bookmarks.db',
            -- Branch configuration
            use_branch_specific = false, -- Enable/disable branch-specific bookmarks (can be toggled at runtime)
        })
        require("lua.plugins.telescope.telescope").load_extension("bookmarks")

        vim.api.nvim_set_hl(0, "BookmarkHighlight", {
            bg = "#3a3a3a",
            underline = true
        })

        vim.api.nvim_set_hl(0, "BookmarkSignHighlight", {
            fg = "#458588",
        })

        local telescope_bookmarks = require("bookmarks.telescope")
        vim.api.nvim_create_user_command("Bookmarks", telescope_bookmarks.bookmarks_picker, {})
        vim.api.nvim_create_user_command("TelescopeBookmarksLists", telescope_bookmarks.lists_picker, {})

        vim.keymap.set("n", "<leader>bl", telescope_bookmarks.bookmarks_picker, { desc = "List bookmarks" })
        vim.keymap.set("n", "<leader>bs", telescope_bookmarks.lists_picker, { desc = "Switch bookmark list" })
        return M
    end,
    cmd = {
        "BookmarkAdd",
        "BookmarkRemove",
        "Bookmarks"
    },
    keys = {
        { "<leader>ba", "<cmd>BookmarkAdd<cr>",            desc = "Add Bookmark" },
        { "<leader>br", "<cmd>BookmarkRemove<cr>",         desc = "Remove Bookmark" },
        { "<leader>bj", desc = "Jump to Next Bookmark" },
        { "<leader>bk", desc = "Jump to Previous Bookmark" },
        { "<leader>bl", "<cmd>Bookmarks<cr>",              desc = "List Bookmarks" },
        { "<leader>bs", desc = "Switch Bookmark List" },
    },
}
