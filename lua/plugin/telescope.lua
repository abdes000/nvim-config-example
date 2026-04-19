return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- optional but recommended
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    "kkharji/sqlite.lua",
    -- optional, if using telescope for vim.ui.select
    "stevearc/dressing.nvim"
  },
  keys = {
    -- Call telescope extension from lua
    {
      "<Leader>fd",
      function()
        require("telescope").extensions.directory.live_grep()         -- find_files|grep_string|live_grep
      end,
      desc = "Select directory for Live Grep",
    },
    -- Call telescope extension as command
    {
      "<Leader>fe",
      "<CMD>Telescope directory find_files<CR>",       -- "find_files"|"grep_string"|"live_grep"
      desc = "Select directory for Find Files",
    },
  },
  config = function()
    require("telescope").setup({
      extensions = {
        aerial = {
          -- Set the width of the first two columns (the second
          -- is relevant only when show_columns is set to 'both')
          col1_width = 4,
          col2_width = 30,
          -- How to format the symbols
          format_symbol = function(symbol_path, filetype)
            if filetype == "json" or filetype == "yaml" then
              return table.concat(symbol_path, ".")
            else
              return symbol_path[#symbol_path]
            end
          end,
          -- Available modes: symbols, lines, both
          show_columns = "both",
        },
      },
    })
    local actions = require("telescope.actions")
    local open_with_trouble = require("trouble.sources.telescope").open

    -- Use this to add more results without clearing the trouble list
    local add_to_trouble = require("trouble.sources.telescope").add

    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        mappings = {
          i = { ["<c-t>"] = open_with_trouble },
          n = { ["<c-t>"] = open_with_trouble },
        },
      },
    })

    require "telescope".load_extension("agrolens")
    require("telescope").extensions = {
      agrolens = {
        debug = false,
        same_type = true,
        include_hidden_buffers = false,
        disable_indentation = false,
        aliases = {}
      }
    }

    require('telescope').setup({
      defaults = {
        layout_config = {
          vertical = { width = 0.5 }
          -- other layout configuration here
        },
        -- other defaults configuration here
      },
      extensions = {
        fzf = {
          fuzzy = true,                             -- false will only do exact matching
          override_generic_sorter = true,           -- override the generic sorter
          override_file_sorter = true,              -- override the file sorter
          case_mode = "smart_case",                 -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        ecolog = {
          shelter = {
            -- Whether to show masked values when copying to clipboard
            mask_on_copy = false,
          },
          -- Default keybindings
          mappings = {
            -- Key to copy value to clipboard
            copy_value = "<C-y>",
            -- Key to copy name to clipboard
            copy_name = "<C-n>",
            -- Key to append value to buffer
            append_value = "<C-a>",
            -- Key to append name to buffer (defaults to <CR>)
            append_name = "<CR>",
            -- Key to edit environment variable
            edit_var = "<C-e>",
          },
        },
        cmdline = {
          -- Adjust telescope picker size and layout
          picker   = {
            layout_config = {
              width  = 120,
              height = 25,
            }
          },
          -- Adjust your mappings
          mappings = {
            complete      = '<Tab>',
            run_selection = '<C-CR>',
            run_input     = '<CR>',
          },
          -- Triggers any shell command using overseer.nvim (`:!`)
          overseer = {
            enabled = true,
          },
        },
        gitmoji = {
          action = function(entry)
            -- entry = {
            --   display = "🐛 Fix a bug.",
            --   index = 4,
            --   ordinal = "Fix a bug.",
            --   value = {
            --     description = "Fix a bug.",
            --     text = ":bug:",
            --     value = "🐛"
            --   }
            -- }
            local emoji = entry.value.value
            vim.ui.input({ prompt = "Enter commit message: " .. emoji .. " " }, function(msg)
              if not msg then
                return
              end
              -- Insert text instead of emoji in message
              local emoji_text = entry.value.text
              vim.cmd(':G commit -m "' .. emoji_text .. ' ' .. msg .. '"')
            end)
          end,
        },
      }
      -- other configuration values here
    })
    require('telescope').load_extension('fzf')


    -- Using vim.keymap.set (recommended)
    vim.keymap.set('n', '<leader>f', function()
      require('telescope.builtin').find_files(
        require('telescope.themes').get_dropdown({ winblend = 10 })
      )
    end, { desc = 'Find files (dropdown)' })
    --If you want to configure the vim_buffer_ previewer (e.g. you want the line to wrap), do this:


    require('telescope').load_extension('pineapple')
    require('telescope').extensions.pineapple.colorschemes()
    require("telescope").load_extension("ui-select")
    -- telescope_keymaps.lua
    local builtin = require('telescope.builtin')

    -- File pickers
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'Search string under cursor' })
    vim.keymap.set('n', '<leader>fb', builtin.git_files, { desc = 'Git files' })

    -- Buffers & history
    vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'List buffers' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Recent files' })
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
    vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Man pages' })

    -- LSP pickers
    vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'LSP references' })
    vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'LSP definitions' })
    vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = 'LSP implementations' })
    vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions, { desc = 'LSP type definitions' })
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Buffer symbols' })
    vim.keymap.set('n', '<leader>lS', builtin.lsp_workspace_symbols, { desc = 'Workspace symbols' })
    vim.keymap.set('n', '<leader>lD', builtin.diagnostics, { desc = 'Diagnostics' })

    -- Git pickers
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })
    vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'Git stash' })

    -- Treesitter
    vim.keymap.set('n', '<leader>ts', builtin.treesitter, { desc = 'Treesitter symbols' })

    -- Misc
    vim.keymap.set('n', '<leader>pp', builtin.planets, { desc = 'Planets demo' })
    vim.keymap.set('n', '<leader>pb', builtin.builtin, { desc = 'Builtin pickers' })
    vim.keymap.set('n', '<leader>pr', builtin.reloader, { desc = 'Reload Lua modules' })
    vim.keymap.set('n', '<leader>ps', builtin.symbols, { desc = 'Symbols' })

    -- Current buffer fuzzy search
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Search in buffer' })
  end
}
