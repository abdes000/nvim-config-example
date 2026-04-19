return {
    "jameswolensky/marker-groups.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",     -- Required
        "ibhagwan/fzf-lua",          -- Optional: fzf-lua picker
        "folke/snacks.nvim",         -- Optional: Snacks picker
        "nvim-telescope/telescope.nvim", -- Optional: Telescope picker
        -- mini.pick is part of mini.nvim; this plugin vendors mini.nvim for tests,
        -- but you can also install mini.nvim explicitly to use mini.pick system-wide
        -- "nvim-mini/mini.nvim",
    },
    keys = {
        -- Marker operations
        { "<leader>ma",  "<cmd>MarkerAdd<cr>",                desc = "Marker: Add marker" },
        { "<leader>mr",  "<cmd>MarkerRemove<cr>",             desc = "Marker: Remove marker at cursor" },
        { "<leader>ml",  "<cmd>MarkerList<cr>",               desc = "Marker: List markers in buffer" },

        -- Viewing & navigation
        { "<leader>mv",  "<cmd>MarkerGroupsView<cr>",         desc = "Marker: Toggle marker viewer drawer" },
        { "<leader>mtg", "<cmd>MarkerGroupsPickerStatus<cr>", desc = "Marker: Picker groups status" },
        { "<leader>mtm", "<cmd>MarkerGroupsPickerStatus<cr>", desc = "Marker: Picker markers status" },
        { "<leader>mh",  "<cmd>MarkerGroupsHealth<cr>",       desc = "Marker: Run health checks" },

        -- Group management
        { "<leader>mgc", "<cmd>MarkerGroupsCreate ",          desc = "Marker: Create group" },
        { "<leader>mgl", "<cmd>MarkerGroupsList<cr>",         desc = "Marker: List groups" },
        { "<leader>mgs", "<cmd>MarkerGroupsSelect ",          desc = "Marker: Select group" },
        { "<leader>mgr", "<cmd>MarkerGroupsRename ",          desc = "Marker: Rename group" },
        { "<leader>mgd", "<cmd>MarkerGroupsDelete ",          desc = "Marker: Delete group" },
    },

    config = function()
        require("marker-groups").setup({
            -- Persistence
            data_dir = vim.fn.stdpath("data") .. "/marker-groups",

            -- Logging
            debug = true,
            log_level = "info", -- "debug" | "info" | "warn" | "error"

            -- Drawer viewer
            drawer_config = {
                width = 60, -- 30..120
                side = "right", -- "left" | "right"
                border = "rounded",
                title_pos = "center",
            },

            -- Context shown around markers in viewer/preview
            context_lines = 2,

            -- Virtual text display & highlight groups
            max_annotation_display = 50, -- truncate long annotations
            highlight_groups = {
                marker = "MarkerGroupsMarker",
                annotation = "MarkerGroupsAnnotation",
                context = "MarkerGroupsContext",
                multiline_start = "MarkerGroupsMultilineStart",
                multiline_end = "MarkerGroupsMultilineEnd",
            },

            -- Keybindings (declarative; override per entry or disable by setting to false)
            keymaps = {
                enabled = true,
                prefix = "<leader>m",
                mappings = {
                    marker = {
                        add = { suffix = "a", mode = { "n", "v" }, desc = "Add marker" },
                        edit = { suffix = "e", desc = "Edit marker at cursor" },
                        delete = { suffix = "d", desc = "Delete marker at cursor" },
                        list = { suffix = "l", desc = "List markers in buffer" },
                        info = { suffix = "i", desc = "Show marker at cursor" },
                    },
                    group = {
                        create = { suffix = "gc", desc = "Create marker group" },
                        select = { suffix = "gs", desc = "Select marker group" },
                        list = { suffix = "gl", desc = "List marker groups" },
                        rename = { suffix = "gr", desc = "Rename marker group" },
                        delete = { suffix = "gd", desc = "Delete marker group" },
                        info = { suffix = "gi", desc = "Show active group info" },
                        from_branch = { suffix = "gb", desc = "Create group from git branch" },
                    },
                    view = { toggle = { suffix = "v", desc = "Toggle drawer marker viewer" } },

                },
            },

            -- Picker backend (default: 'vim')
            -- Accepted values: 'vim' | 'snacks' | 'fzf-lua' | 'mini.pick' | 'telescope'
            -- Invalid values fall back to 'vim'.
            picker = 'telescope',
        })
    end,
}
