return {
    "taigrr/glaze.nvim",
    config = function()
        require("glaze").setup()
        require("glaze").setup({
            -- UI settings
            ui = {
                border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
                size = { width = 0.7, height = 0.8 },
                icons = {
                    pending = "○",
                    running = "◐",
                    done = "●",
                    error = "✗",
                    binary = "󰆍",
                },
                use_system_theming = false, -- Use nvim theme instead of doughnut colors
            },

            -- Parallel installations
            concurrency = 4,

            -- Go command (auto-detects goenv)
            go_cmd = { "go" },

            -- Auto-install missing binaries on register
            auto_install = {
                enabled = true,
                silent = false,
            },

            -- Auto-check for updates
            auto_check = {
                enabled = true,
                frequency = "daily", -- "daily", "weekly", or hours as number
            },

            -- Auto-update when newer versions found
            auto_update = {
                enabled = true --Requires auto_check
            },
        })
    end,
}
