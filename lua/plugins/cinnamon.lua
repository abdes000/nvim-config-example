return {
    "declancm/cinnamon.nvim",
    version = "*", -- use latest release
    opts = {
        -- Disable the plugin
        disabled = false,

        keymaps = {
            -- Enable the provided 'basic' keymaps
            basic = false,
            -- Enable the provided 'extra' keymaps
            extra = false,
        },

        ---@class ScrollOptions
        options = {
            -- The scrolling mode
            -- `cursor`: animate cursor and window scrolling for any movement
            -- `window`: animate window scrolling ONLY when the cursor moves out of view
            mode = "cursor",

            -- Only animate scrolling if a count is provided
            count_only = false,

            -- Delay between each movement step (in ms)
            delay = 5,

            max_delta = {
                -- Maximum distance for line movements before scroll
                -- animation is skipped. Set to `false` to disable
                line = false,
                -- Maximum distance for column movements before scroll
                -- animation is skipped. Set to `false` to disable
                column = false,
                -- Maximum duration for a movement (in ms). Automatically scales the
                -- delay and step size
                time = 1000,
            },

            step_size = {
                -- Number of cursor/window lines moved per step
                vertical = 1,
                -- Number of cursor/window columns moved per step
                horizontal = 2,
            },

            -- Optional post-movement callback. Not called if the movement is interrupted
            callback = function() end,
        },
    },
    config = function()
        local cinnamon = require("cinnamon")

        -- Enable Cinnamon globally
        cinnamon.setup({
            default_keymaps = false, -- we’ll define them manually
            extra_keymaps = false,
            extended_keymaps = false,
        })

        ----------------------------------------------------------------------
        -- Basic Keymaps (scroll animation for half-window, page, paragraph, search, cursor)
        ----------------------------------------------------------------------
        local basic = {
            -- Half-window movements
            { "<C-u>",      "scroll", "Scroll half-page up" },
            { "<C-d>",      "scroll", "Scroll half-page down" },

            -- Page movements
            { "<C-b>",      "scroll", "Scroll page up" },
            { "<C-f>",      "scroll", "Scroll page down" },
            { "<PageUp>",   "scroll", "Scroll page up" },
            { "<PageDown>", "scroll", "Scroll page down" },

            -- Paragraph movements
            { "{",          "scroll", "Scroll paragraph up" },
            { "}",          "scroll", "Scroll paragraph down" },

            -- Search results
            { "n",          "scroll", "Next search result" },
            { "N",          "scroll", "Prev search result" },
            { "*",          "scroll", "Search under cursor forward" },
            { "#",          "scroll", "Search under cursor backward" },
            { "g*",         "scroll", "Search under cursor forward (partial)" },
            { "g#",         "scroll", "Search under cursor backward (partial)" },

            -- Cursor location jumps
            { "<C-o>",      "scroll", "Jump to older cursor position" },
            { "<C-i>",      "scroll", "Jump to newer cursor position" },
        }

        ----------------------------------------------------------------------
        -- Extra Keymaps (scroll animation for file, line, screen, horizontal, vertical)
        ----------------------------------------------------------------------
        local extra = {
            -- Start/end of file
            { "gg",      "scroll", "Go to start of file" },
            { "G",       "scroll", "Go to end of file" },

            -- Line number jumps
            { "0",       "scroll", "Go to beginning of line" },
            { "^",       "scroll", "Go to first non-whitespace" },
            { "$",       "scroll", "Go to end of line" },

            -- Screen scrolling
            { "zz",      "scroll", "Center screen" },
            { "zt",      "scroll", "Top of screen" },
            { "zb",      "scroll", "Bottom of screen" },
            { "z.",      "scroll", "Center screen (alt)" },
            { "z<CR>",   "scroll", "Top of screen (alt)" },
            { "z-",      "scroll", "Bottom of screen (alt)" },
            { "z^",      "scroll", "Top of screen (cursor)" },
            { "z+",      "scroll", "Bottom of screen (cursor)" },
            { "<C-y>",   "scroll", "Scroll screen up one line" },
            { "<C-e>",   "scroll", "Scroll screen down one line" },

            -- Horizontal scrolling
            { "zH",      "scroll", "Scroll screen left" },
            { "zL",      "scroll", "Scroll screen right" },
            { "zs",      "scroll", "Scroll cursor to left" },
            { "ze",      "scroll", "Scroll cursor to right" },
            { "zh",      "scroll", "Scroll left" },
            { "zl",      "scroll", "Scroll right" },

            -- Up/down movements
            { "j",       "scroll", "Move down" },
            { "k",       "scroll", "Move up" },
            { "<Up>",    "scroll", "Move up" },
            { "<Down>",  "scroll", "Move down" },
            { "gj",      "scroll", "Move down (wrap)" },
            { "gk",      "scroll", "Move up (wrap)" },
            { "g<Up>",   "scroll", "Move up (wrap)" },
            { "g<Down>", "scroll", "Move down (wrap)" },

            -- Left/right movements
            { "h",       "scroll", "Move left" },
            { "l",       "scroll", "Move right" },
            { "<Left>",  "scroll", "Move left" },
            { "<Right>", "scroll", "Move right" },
        }

        ----------------------------------------------------------------------
        -- Register all keymaps with Cinnamon
        ----------------------------------------------------------------------
        for _, map in ipairs(basic) do
            cinnamon.scroll(map[1])
        end
        for _, map in ipairs(extra) do
            cinnamon.scroll(map[1])
        end
        -- Flash.nvim integration:
        local flash = require("flash")
        local jump = require("flash.jump")

        flash.setup({
            action = function(match, state)
                cinnamon.scroll(function()
                    jump.jump(match, state)
                    jump.on_jump(state)
                end)
            end,
        })
    end
}
