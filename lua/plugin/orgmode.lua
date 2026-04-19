return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        -- Setup orgmode
        require('orgmode').setup({
            org_agenda_files = '~/orgfiles/**/*',
            org_default_notes_file = '~/orgfiles/refile.org',
        })

        -- Experimental LSP support
        vim.lsp.enable('org')
    end,
    keys = {
        -- Agenda & capture
        { "<leader>oa",  "<cmd>OrgAgenda<cr>",                      desc = "Orgmode: Open agenda prompt" },
        { "<leader>oc",  "<cmd>OrgCapture<cr>",                     desc = "Orgmode: Open capture prompt" },

        -- Org command suite
        { "<leader>oh",  "<cmd>Org help<cr>",                       desc = "Orgmode: Open documentation" },
        { "<leader>oH",  "<cmd>Org helpgrep<cr>",                   desc = "Orgmode: Search documentation" },
        { "<leader>oi",  "<cmd>Org install_treesitter_grammar<cr>", desc = "Orgmode: Install/reinstall treesitter grammar" },
        { "<leader>os",  "<cmd>Org store_link<cr>",                 desc = "Orgmode: Store link to headline" },
        { "<leader>oi",  "<cmd>Org indent_mode<cr>",                desc = "Orgmode: Toggle virtual indent mode" },

        -- Agenda variations
        { "<leader>oam", "<cmd>Org agenda M<cr>",                   desc = "Orgmode: Agenda tags_todo view" },
        { "<leader>oat", "<cmd>Org agenda t<cr>",                   desc = "Orgmode: Agenda todo view" },

        -- Capture variations
        { "<leader>oct", "<cmd>Org capture t<cr>",                  desc = "Orgmode: Capture template (t)" },

        -- Extra editing helpers
        { "<leader>otc", "<cmd>OrgToggleCheckbox<cr>",              desc = "Orgmode: Toggle checkbox" },
        { "<leader>otd", "<cmd>OrgTodo<cr>",                        desc = "Orgmode: Toggle TODO state" },
        { "<leader>ote", "<cmd>OrgEditSpecial<cr>",                 desc = "Orgmode: Edit special block" },
    },

}
