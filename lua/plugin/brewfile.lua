return {
    "piersolenski/brewfile.nvim",
    opts = {
        -- Auto-dump Brewfile after brew commands finish
        dump_on_change = true,
        -- Show confirmation prompts for uninstall actions
        confirmation_prompt = true,
    },
    keys = {
        {
            "<leader>b",
            desc = "Brewfile",
        },
        {
            "<leader>bi",
            function()
                require("brewfile").install()
            end,
            desc = "Brew install package",
            mode = { "n" },
        },
        {
            "<leader>br",
            function()
                require("brewfile").dump()
            end,
            desc = "Dump Brewfile and refresh the buffer",
            mode = { "n" },
        },
        {
            "<leader>bo",
            function()
                require("brewfile").open_homepage()
            end,
            desc = "Open package homepage",
            mode = { "n" },
        },
        {
            "<leader>bd",
            function()
                require("brewfile").uninstall()
            end,
            desc = "Brew uninstall package",
            mode = { "n" },
        },
        {
            "<leader>bD",
            function()
                require("brewfile").force_uninstall()
            end,
            desc = "Brew force uninstall package",
            mode = { "n" },
        },
        {
            "<leader>bI",
            function()
                require("brewfile").info()
            end,
            desc = "Brew package info",
            mode = { "n" },
        },
        {
            "<leader>bu",
            function()
                require("brewfile").upgrade()
            end,
            desc = "Brew upgrade package",
            mode = { "n" },
        },
    },
}
