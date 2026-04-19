return -- Lazy
{
    'piersolenski/import.nvim',
    dependencies = {
        -- One of the following pickers is required:
        'nvim-telescope/telescope.nvim',
        -- 'folke/snacks.nvim',
        -- 'ibhagwan/fzf-lua',
    },
    opts = {
            -- The picker to use
            picker = "telescope",
            -- Imports can be added at a specified line whilst keeping the cursor in place
            insert_at_top = true,
            -- Optionally support additional languages or modify existing languages...
            custom_languages = {}
    },
    keys = {
        {
            "<leader>i",
            function()
                require("import").pick()
            end,
            desc = "Import",
        },
    },
}
