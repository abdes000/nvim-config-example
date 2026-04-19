return {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10, -- Low priority to catch other plugins' keybindings
    config = function()
        require("tiny-glimmer").setup()
        require("tiny-glimmer").setup({
            -- Enable/disable the plugin
            enabled = true,

            -- Disable warnings for debugging highlight issues
            disable_warnings = true,

            -- Automatically reload highlights when colorscheme changes
            -- When enabled, cached highlights will be refreshed on ColorScheme autocmd
            autoreload = false,

            -- Animation refresh rate in milliseconds
            refresh_interval_ms = 8,

            -- Timeout in milliseconds to wait after the last edit before processing animations
            -- This uses a debouncing approach: the timer restarts on each edit, and only fires
            -- when edits stop for this duration. This properly handles multi-location atomic
            -- edits from surround plugins and similar tools (default: 50)
            text_change_batch_timeout_ms = 50,

            -- Automatic keybinding overwrites
            overwrite = {
                -- Automatically map keys to overwrite operations
                -- Set to false if you have custom mappings or prefer manual API calls
                auto_map = true,

                -- Yank operation animation
                yank = {
                    enabled = true,
                    default_animation = "fade",
                },

                -- Search navigation animation
                search = {
                    enabled = false,
                    default_animation = "pulse",
                    next_mapping = "n", -- Key for next match
                    prev_mapping = "N", -- Key for previous match
                },

                -- Paste operation animation
                paste = {
                    enabled = true,
                    default_animation = "reverse_fade",
                    paste_mapping = "p", -- Paste after cursor
                    Paste_mapping = "P", -- Paste before cursor
                },

                -- Undo operation animation
                undo = {
                    enabled = false,
                    default_animation = {
                        name = "fade",
                        settings = {
                            from_color = "DiffDelete",
                            max_duration = 500,
                            min_duration = 500,
                        },
                    },
                    undo_mapping = "u",
                },

                -- Redo operation animation
                redo = {
                    enabled = false,
                    default_animation = {
                        name = "fade",
                        settings = {
                            from_color = "DiffAdd",
                            max_duration = 500,
                            min_duration = 500,
                        },
                    },
                    redo_mapping = "<c-r>",
                },
            },

            -- Third-party plugin integrations
            support = {
                -- Support for gbprod/substitute.nvim
                -- Usage: require("substitute").setup({
                --     on_substitute = require("tiny-glimmer.support.substitute").substitute_cb,
                --     highlight_substituted_text = { enabled = false },
                -- })
                substitute = {
                    enabled = false,
                    default_animation = "fade",
                },
            },

            -- Special animation presets
            presets = {
                -- Pulsar-style cursor highlighting on specific events
                pulsar = {
                    enabled = false,
                    on_events = { "CursorMoved", "CmdlineEnter", "WinEnter" },
                    default_animation = {
                        name = "fade",
                        settings = {
                            max_duration = 1000,
                            min_duration = 1000,
                            from_color = "DiffDelete",
                            to_color = "Normal",
                        },
                    },
                },
            },

            -- Override background color for animations (for transparent backgrounds)
            transparency_color = nil,

            -- Animation configurations
            animations = {
                fade = {
                    max_duration = 400,          -- Maximum animation duration in ms
                    min_duration = 300,          -- Minimum animation duration in ms
                    easing = "outQuad",          -- Easing function
                    chars_for_max_duration = 10, -- Character count for max duration
                    from_color = "Visual",       -- Start color (highlight group or hex)
                    to_color = "Normal",         -- End color (highlight group or hex)
                    font_style = {},             -- Additional font styling (e.g. { bold = true }, see `:h nvim_set_hl`)
                },
                reverse_fade = {
                    max_duration = 380,
                    min_duration = 300,
                    easing = "outBack",
                    chars_for_max_duration = 10,
                    from_color = "Visual",
                    to_color = "Normal",
                    font_style = {},
                },
                bounce = {
                    max_duration = 500,
                    min_duration = 400,
                    chars_for_max_duration = 20,
                    oscillation_count = 1, -- Number of bounces
                    from_color = "Visual",
                    to_color = "Normal",
                    font_style = {},
                },
                left_to_right = {
                    max_duration = 350,
                    min_duration = 350,
                    min_progress = 0.85,
                    chars_for_max_duration = 25,
                    lingering_time = 50, -- Time to linger after completion
                    from_color = "Visual",
                    to_color = "Normal",
                    font_style = {},
                },
                pulse = {
                    max_duration = 600,
                    min_duration = 400,
                    chars_for_max_duration = 15,
                    pulse_count = 2, -- Number of pulses
                    intensity = 1.2, -- Pulse intensity
                    from_color = "Visual",
                    to_color = "Normal",
                    font_style = {},
                },
                rainbow = {
                    max_duration = 600,
                    min_duration = 350,
                    chars_for_max_duration = 20,
                    -- Note: Rainbow animation does not use from_color/to_color
                    font_style = {},
                },

                -- Custom animation example
                custom = {
                    max_duration = 350,
                    chars_for_max_duration = 40,
                    color = "#ff0000", -- Custom property

                    -- Custom effect function
                    -- @param self table - The effect object with settings
                    -- @param progress number - Animation progress [0, 1]
                    -- @return string color - Hex color or highlight group
                    -- @return number progress - How much of the animation to draw
                    effect = function(self, progress)
                        return self.settings.color, progress
                    end,
                },
            },

            -- Filetypes to disable hijacking/overwrites
            hijack_ft_disabled = {
                "alpha",
                "snacks_dashboard",
            },

            -- Virtual text display priority
            virt_text = {
                priority = 2048, -- Higher values appear above other plugins
            },
        })
        -- Animate on buffer write
        vim.api.nvim_create_autocmd("BufWritePost", {
            callback = function()
                glimmer.cursor_line("pulse", {
                    max_duration = 300,
                    from_color = "DiffAdd",
                })
            end,
        })

        -- Animate search results
        vim.keymap.set("n", "n", function()
            vim.cmd("normal! n")
            local pos = vim.api.nvim_win_get_cursor(0)
            glimmer.create_animation({
                range = glimmer.get_cursor_range(),
                duration = 400,
                from_color = "IncSearch",
                to_color = "Normal",
                effect = "pulse",
            })
        end)
    end,

    keys = {
        -- Plugin state
        { "<leader>ge", function() require("tiny-glimmer").enable() end,  desc = "Glimmer: Enable animations" },
        { "<leader>gd", function() require("tiny-glimmer").disable() end, desc = "Glimmer: Disable animations" },
        { "<leader>gt", function() require("tiny-glimmer").toggle() end,  desc = "Glimmer: Toggle animations" },

        -- Highlight changes
        {
            "<leader>gh",
            function()
                require("tiny-glimmer").change_hl("fade", { from_color = "#FF0000", to_color = "#0000FF" })
            end,
            desc = "Glimmer: Change highlight (fade example)",
        },
        {
            "<leader>gH",
            function()
                local anim = vim.fn.input("Animation (fade/pulse/all): ")
                local from = vim.fn.input("From color (hex): ")
                local to   = vim.fn.input("To color (hex): ")
                require("tiny-glimmer").change_hl(anim ~= "" and anim or "all", { from_color = from, to_color = to })
            end,
            desc = "Glimmer: Change highlight (prompt)",
        },

        -- Search overrides
        { "gn",         function() require("tiny-glimmer").search_next() end,         desc = "Glimmer: Search next (n)" },
        { "gN",         function() require("tiny-glimmer").search_prev() end,         desc = "Glimmer: Search prev (N)" },
        { "g*",         function() require("tiny-glimmer").search_under_cursor() end, desc = "Glimmer: Search under cursor (*)" },

        -- Paste overrides
        { "gp",         function() require("tiny-glimmer").paste() end,               desc = "Glimmer: Paste (p)" },
        { "gP",         function() require("tiny-glimmer").Paste() end,               desc = "Glimmer: Paste before (P)" },

        -- Undo/redo overrides
        { "gu",         function() require("tiny-glimmer").undo() end,                desc = "Glimmer: Undo" },
        { "gr",         function() require("tiny-glimmer").redo() end,                desc = "Glimmer: Redo" },

        -- Refresh highlights
        { "<leader>ga", function() require("tiny-glimmer").apply() end,               desc = "Glimmer: Apply highlights after theme change" },
    },

}
