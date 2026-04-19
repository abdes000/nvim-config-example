return {
  "desdic/agrolens.nvim",
    opts = {
        -- Enable/Disable debug messages (is put in ~/.cache/nvim/agrolens.log)
        debug = true,

        -- Some tree-sitter plugins uses hidden buffers
        -- and we can enable those to if we want
        include_hidden_buffers = false,

        -- Make sure the query only runs on
        -- same filetype as the current one
        same_type = true,

        -- Match a given string or object
        -- Example `:Telescope agrolens query=callings buffers=all same_type=false match=name,object`
        -- this will query all callings but only those who match the word on the cursor
        match = nil,

        -- Disable displaying indententations in telescope
        disable_indentation = false,

        -- Alias can be used to join several queries into a single name
        -- Example: `aliases = { yamllist = "docker-compose,github-workflow-steps"}`
        aliases = {
            yamllist = "docker-compose,github-workflow-steps",
            work = "cheflxchost,github-workflow-steps,pytest",
        },

        -- Several internal functions can also be overwritten
        --
        -- Default entry maker (telescope only)
        -- entry_maker = agrolens.entry_maker
        --
        -- Default way of finding current directory
        -- cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.uv.cwd()
        --
        -- Default previewer (telescope only)
        -- previewer = conf.grep_previewer(opts)
        --
        -- Default sorting (telescope only)
        -- sorter = conf.generic_sorter(opts)

        -- Default enable devicons
        disable_devicons = true,

        -- display length
        display_width = 150,

        -- force long path name even when only a single buffer
        force_long_filepath = true,

        -- Layout for snacks picker
        snacks_layout = { preview = true },
    }
}
