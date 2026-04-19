return {
    "aPeoplesCalendar/apc.nvim",
    dependencies = {
        "rcarriga/nvim-notify",
    },
    keys = {
        -- Main calendar
        { "<leader>ac", "<cmd>APeoplesCalendar<cr>",        desc = "APC: Open today's calendar" },

        -- Variations
        { "<leader>ad", "<cmd>APeoplesCalendar ",           desc = "APC: Open calendar for date (prompt)" },
        { "<leader>as", "<cmd>APeoplesCalendar search ",    desc = "APC: Search calendar events" },
        { "<leader>at", "<cmd>APeoplesCalendar tags ",      desc = "APC: Filter events by tag" },
        { "<leader>ar", "<cmd>APeoplesCalendar random<cr>", desc = "APC: Open random calendar entry" },
    },


    event = "VeryLazy",
    config = function()
        require("apeoplescalendar").setup(
            {
                auto_teaser_filetypes = { "dashboard", "alpha", "starter", }, -- will enable running the teaser automatically for listed filetypes
            }
        )                                                                     -- configuration options are described below
    end,
}
