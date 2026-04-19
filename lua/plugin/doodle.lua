return {
    "apdot/doodle",
    dependencies = {
        "kkharji/sqlite.lua",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("doodle").setup({
            settings = {
                -- This is the only required setting for sync to work.
                -- Set it to the absolute path of your private notes repository.
                git_repo = "path/to/your/initialized/git/repository",
                sync = true,
            }
        })
    end,
    keys = {
        {
            "<space>df",
            function() require("doodle"):toggle_finder() end,
            desc = "Doodle Finder"
        },
        {
            "<space>ds",
            function() require("doodle"):sync() end,
            desc = "Doodle Sync"
        },
        {
            "<space>dl",
            function() require("doodle"):toggle_links() end,
            desc = "Doodle Links"
        },
        -- Core doodle mode
        { "<leader>do",   "<cmd>DoodleToggle<cr>",      desc = "Doodle: Toggle drawing mode" },
        { "<leader>ds",   "<cmd>DoodleStart<cr>",       desc = "Doodle: Start drawing session" },
        { "<leader>de",   "<cmd>DoodleEnd<cr>",         desc = "Doodle: End drawing session" },
        { "<leader>dc",   "<cmd>DoodleClear<cr>",       desc = "Doodle: Clear canvas" },

        -- Tools
        { "<leader>dp",   "<cmd>DoodlePen<cr>",         desc = "Doodle: Pen tool" },
        { "<leader>dl",   "<cmd>DoodleLine<cr>",        desc = "Doodle: Line tool" },
        { "<leader>dr",   "<cmd>DoodleRect<cr>",        desc = "Doodle: Rectangle tool" },
        { "<leader>dt",   "<cmd>DoodleText<cr>",        desc = "Doodle: Text tool" },
        { "<leader>df",   "<cmd>DoodleFill<cr>",        desc = "Doodle: Fill tool" },
        { "<leader>doe",  "<cmd>DoodleErase<cr>",       desc = "Doodle: Eraser tool" },

        -- Layers
        { "<leader>dna",  "<cmd>DoodleNewLayer<cr>",    desc = "Doodle: New layer" },
        { "<leader>dnd",  "<cmd>DoodleDeleteLayer<cr>", desc = "Doodle: Delete layer" },
        { "<leader>dnu",  "<cmd>DoodleLayerUp<cr>",     desc = "Doodle: Move layer up" },
        { "<leader>dndn", "<cmd>DoodleLayerDown<cr>",   desc = "Doodle: Move layer down" },
        { "<leader>dnl",  "<cmd>DoodleListLayers<cr>",  desc = "Doodle: List layers" },

        -- Export / Import
        { "<leader>dxp",  "<cmd>DoodleExportPng<cr>",   desc = "Doodle: Export as PNG" },
        { "<leader>dxj",  "<cmd>DoodleExportJson<cr>",  desc = "Doodle: Export as JSON" },
        { "<leader>dxl",  "<cmd>DoodleExportSvg<cr>",   desc = "Doodle: Export as SVG" },
        { "<leader>dim",  "<cmd>DoodleImport<cr>",      desc = "Doodle: Import drawing" },

        -- Settings
        { "<leader>dsz",  "<cmd>DoodleSetSize<cr>",     desc = "Doodle: Set brush size" },
        { "<leader>dsc",  "<cmd>DoodleSetColor<cr>",    desc = "Doodle: Set brush color" },
        { "<leader>dss",  "<cmd>DoodleSettings<cr>",    desc = "Doodle: Open settings" },

    },
}
