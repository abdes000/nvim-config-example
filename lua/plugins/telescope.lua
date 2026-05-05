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
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    -- Guard optional trouble.nvim telescope integration
    local open_with_trouble, add_to_trouble
    do
      local ok, trouble_tel = pcall(require, "trouble.sources.telescope")
      if ok and trouble_tel then
        open_with_trouble = trouble_tel.open
        add_to_trouble    = trouble_tel.add
      end
    end

    -- Single consolidated telescope.setup() call
    telescope.setup({
      defaults = {
        layout_config = {
          vertical = { width = 0.5 },
        },
        mappings = {
          i = { ["<c-t>"] = open_with_trouble },
          n = { ["<c-t>"] = open_with_trouble },
        },
      },
      extensions = {
        aerial = {
          col1_width = 4,
          col2_width = 30,
          format_symbol = function(symbol_path, filetype)
            if filetype == "json" or filetype == "yaml" then
              return table.concat(symbol_path, ".")
            else
              return symbol_path[#symbol_path]
            end
          end,
          show_columns = "both",
        },
        agrolens = {
          -- agrolens extension config
          debug = false,
          same_type = true,
          include_hidden_buffers = false,
          disable_indentation = false,
          aliases = {},
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ecolog = {
          shelter = {
            mask_on_copy = false,
          },
          mappings = {
            copy_value  = "<C-y>",
            copy_name   = "<C-n>",
            append_value = "<C-a>",
            append_name  = "<CR>",
            edit_var     = "<C-e>",
          },
        },
        cmdline = {
          picker = {
            layout_config = {
              width  = 120,
              height = 25,
            },
          },
          mappings = {
            complete      = '<Tab>',
            run_selection = '<C-CR>',
            run_input     = '<CR>',
          },
          overseer = { enabled = true },
        },
        gitmoji = {
          action = function(entry)
            local emoji = entry.value.value
            vim.ui.input({ prompt = "Enter commit message: " .. emoji .. " " }, function(msg)
              if not msg then return end
              local emoji_text = entry.value.text
              vim.cmd(':G commit -m "' .. emoji_text .. ' ' .. msg .. '"')
            end)
          end,
        },
      },
    })

    -- Load extensions safely (pcall prevents errors when optional plugins are absent)
    local function safe_load(ext)
      pcall(telescope.load_extension, ext)
    end

    safe_load('fzf')
    safe_load('agrolens')
    safe_load('pineapple')          -- loads colorscheme picker; do NOT call it here at startup
    safe_load('ui-select')          -- requires nvim-telescope/telescope-ui-select.nvim

    -- File pickers
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', function()
      builtin.find_files(require('telescope.themes').get_dropdown({ winblend = 10 }))
    end, { desc = 'Find files (dropdown)' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files,              { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep,               { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fs', builtin.grep_string,             { desc = 'Search string under cursor' })
    vim.keymap.set('n', '<leader>fb', builtin.git_files,               { desc = 'Git files' })

    -- Buffers & history
    vim.keymap.set('n', '<leader>bb', builtin.buffers,                 { desc = 'List buffers' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles,                { desc = 'Recent files' })
    vim.keymap.set('n', '<leader>fc', builtin.commands,                { desc = 'Commands' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags,               { desc = 'Help tags' })
    vim.keymap.set('n', '<leader>fm', builtin.man_pages,               { desc = 'Man pages' })

    -- LSP pickers
    vim.keymap.set('n', '<leader>lr', builtin.lsp_references,          { desc = 'LSP references' })
    vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions,         { desc = 'LSP definitions' })
    vim.keymap.set('n', '<leader>li', builtin.lsp_implementations,     { desc = 'LSP implementations' })
    vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions,    { desc = 'LSP type definitions' })
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols,    { desc = 'Buffer symbols' })
    vim.keymap.set('n', '<leader>lS', builtin.lsp_workspace_symbols,   { desc = 'Workspace symbols' })
    vim.keymap.set('n', '<leader>lD', builtin.diagnostics,             { desc = 'Diagnostics' })

    -- Git pickers
    vim.keymap.set('n', '<leader>gc', builtin.git_commits,             { desc = 'Git commits' })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches,            { desc = 'Git branches' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status,              { desc = 'Git status' })
    vim.keymap.set('n', '<leader>gS', builtin.git_stash,               { desc = 'Git stash' })

    -- Treesitter
    vim.keymap.set('n', '<leader>ts', builtin.treesitter,              { desc = 'Treesitter symbols' })

    -- Misc
    vim.keymap.set('n', '<leader>pp', builtin.planets,                 { desc = 'Planets demo' })
    vim.keymap.set('n', '<leader>pb', builtin.builtin,                 { desc = 'Builtin pickers' })
    vim.keymap.set('n', '<leader>pr', builtin.reloader,                { desc = 'Reload Lua modules' })
    vim.keymap.set('n', '<leader>ps', builtin.symbols,                 { desc = 'Symbols' })
    vim.keymap.set('n', '<leader>/',  builtin.current_buffer_fuzzy_find, { desc = 'Search in buffer' })
  end
}
