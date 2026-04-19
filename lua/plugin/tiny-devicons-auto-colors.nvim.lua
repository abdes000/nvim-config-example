return {
    "rachartier/tiny-devicons-auto-colors.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    event = "VeryLazy",
    config = function()
        -- You can add as many colors as you like. More colors is better to estimate the nearest color for each devicon.
        local theme_colors = require("catppuccin.palettes").get_palette("macchiato")

        require('tiny-devicons-auto-colors').setup({
            colors = theme_colors,
            ----or----
            --     colors = {
            --     "#0000ff",
            --     "#00ffe6",
            --     "#00ff00",
            --     "#ff00ff",
            --     "#ff8000",
            --     "#6e00ff",
            --     "#ff0000",
            --     "#ffffff",
            --     "#ffff00",
            --     "#00a1ff",
            --     "#00ffe6"
            -- },
            -- Adjusts factors to get a better color matching.
            factors = {
                lightness = 1.75, -- Adjust the lightness factor.
                chroma = 1, -- Adjust the chroma factor.
                hue = 1.25, -- Adjust the hue factor.
            },

            -- Cache greatly improve the performance of the plugin. It saves all the matchings in a file.
            cache = {
                enabled = true,
                path = vim.fn.stdpath("cache") .. "/tiny-devicons-auto-colors-cache.json",
            },

            -- Precise search can result in better colors matching by automatically tweaking the factors.
            -- It's nice to let it enabled when cache is enabled.
            precise_search = {
                enabled = true,
                iteration = 10, -- It goes hand in hand with 'precision'
                precision = 20, -- The higher the precision, better the search is
                threshold = 23, -- Threshold to consider a color as a match (larger is more permissive)
            },

            -- A list of icon name to ignore.
            -- You can refer to: https://github.com/nvim-tree/nvim-web-devicons/blob/master/lua/nvim-web-devicons/icons-default.lua
            -- to get the icon's name.
            --
            -- example:
            -- ignore = {
            -- 		"lua",
            -- 		"vim",
            -- 		"cs",
            -- 		"json"
            -- }
            ignore = {
            },

            -- Automatically reload the colors when the colorscheme changes.
            -- Warning: when reloaded, it overrides the colors that you set in `colors`.
            -- It can produce varying results according to the colorscheme, so if you always use the same colorscheme, you can keep it disabled.
            autoreload = false,
        })
    end
}
