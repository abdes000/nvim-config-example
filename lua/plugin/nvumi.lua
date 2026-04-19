return {
    "josephburgess/nvumi",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        virtual_text = "newline", -- or "inline"
        prefix = " 🚀 ", -- prefix shown before the output
        date_format = "iso", -- or: "uk", "us", "long"
        keys = {
            run = "<CR>", -- run/refresh calculations
            reset = "R", -- reset buffer
            yank = "<leader>y", -- yank output of current line
            yank_all = "<leader>Y", -- yank all outputs
        },
        custom_conversions = {
            {
                id = "kmh",
                phrases = "kmh, kmph, klicks, kilometers per hour",
                base_unit = "speed",
                format = "km/h",
                ratio = 1,
            },
            {
                id = "mph",
                phrases = "mph, miles per hour",
                base_unit = "speed",
                format = "mph",
                ratio = 1.609344, -- 1 mph = 1.609344 km/h
            },
        },
        
    }
}
