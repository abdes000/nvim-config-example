return {
    "athar-qadri/weather.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required for HTTP requests
        "rcarriga/nvim-notify",  -- Optional, for notifications
        'nvim-lualine/lualine.nvim',
    },
    config = function()
        local weather = require("weather")
        weather:setup({
            settings = {
                update_interval = 60 * 10 * 1000, -- 10 minutes
                minimum_magnitude = 5,
                location = { lat = 34.0787, lon = 74.7659 },
                temperature_unit = "celsius",
            },
        })
        require('weather'):setup({
            settings = {
                update_interval = 15 * 60 * 1000,  -- 15 minutes in milliseconds
                temperature_unit = "celsius",      -- "celsius" or "fahrenheit"
                location = { lat = 37.7749, lon = -122.4194 }, -- Optional fixed location
            },
            default = {
                minimum_magnitude = 4.0,   -- Minimum earthquake magnitude for alerts
                minimum_radius = 20,       -- Minimum radius in km for earthquake alerts
                default_sources = { "meteo", "usgs" }, -- Data sources
            },
        })
        require("weather.notify").start() -- Start notifications
    end,
}
