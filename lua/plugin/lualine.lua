return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  config = function()
    local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = "lualine_c_normal",
    })
    table.insert(opts.sections.lualine_c, {
      symbols.get,
      cond = symbols.has,
    })
    local hot = {
      'Reloader',
    }
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
          fmt = string.lower
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16, -- ~60fps
          events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
          },
        }
      },
      sections = {
        lualine_a = {
          'mode',
          { 'mode', fmt = function(str) return str:sub(1, 1) end },
          icons_enabled = true, -- Enables the display of icons alongside the component.
          -- Defines the icon to be displayed in front of the component.
          -- Can be string|table
          -- As table it must contain the icon as first entry and can use
          -- color option to custom color the icon. Example:
          -- {'branch', icon = ''} / {'branch', icon = {'', color={fg='green'}}}

          -- icon position can also be set to the right side from table. Example:
          -- {'branch', icon = {'', align='right', color={fg='green'}}}
          icon = nil,

          separator = nil, -- Determines what separator to use for the component.
          -- Note:
          --  When a string is provided it's treated as component_separator.
          --  When a table is provided it's treated as section_separator.
          --  Passing an empty string disables the separator.
          --
          -- These options can be used to set colored separators
          -- around a component.
          --
          -- The options need to be set as such:
          --   separator = { left = '', right = ''}
          --
          -- Where left will be placed on left side of component,
          -- and right will be placed on its right.
          --

          cond = nil,         -- Condition function, the component is loaded when the function returns `true`.

          draw_empty = false, -- Whether to draw component even if it's empty.
          -- Might be useful if you want just the separator.

          -- Defines a custom color for the component:
          --
          -- 'highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' } | function
          -- Note:
          --  '|' is synonymous with 'or', meaning a different acceptable format for that placeholder.
          -- color function has to return one of other color types ('highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' })
          -- color functions can be used to have different colors based on state as shown below.
          --
          -- Examples:
          --   color = { fg = '#ffaa88', bg = 'grey', gui='italic,bold' },
          --   color = { fg = 204 }   -- When fg/bg are omitted, they default to the your theme's fg/bg.
          --   color = 'WarningMsg'   -- Highlight groups can also be used.
          --   color = function(section)
          --      return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
          --   end,
          color = nil, -- The default is your theme's color for that section and mode.

          -- Specify what type a component is, if omitted, lualine will guess it for you.
          --
          -- Available types are:
          --   [format: type_name(example)], mod(branch/filename),
          --   stl(%f/%m), var(g:coc_status/bo:modifiable),
          --   lua_expr(lua expressions), vim_fun(viml function name)
          --
          -- Note:
          -- lua_expr is short for lua-expression and vim_fun is short for vim-function.
          type = nil,

          padding = 1, -- Adds padding to the left and right of components.
          -- Padding can be specified to left or right independently, e.g.:
          --   padding = { left = left_padding, right = right_padding }

          fmt = nil, -- Format function, formats the component's output.
          -- This function receives two arguments:
          -- - string that is going to be displayed and
          --   that can be changed, enhanced and etc.
          -- - context object with information you might
          --   need. E.g. tabnr if used with tabs.
          on_click = nil, -- takes a function that is called when component is clicked with mouse.
          -- the function receives several arguments
          -- - number of clicks in case of multiple clicks
          -- - mouse button used (l(left)/r(right)/m(middle)/...)
          -- - modifiers pressed (s(shift)/c(ctrl)/a(alt)/m(meta)...)
          {
            'buffers',
            show_filename_only = true,       -- Shows shortened relative path when set to false.
            hide_filename_extension = false, -- Hide filename extension when set to true.
            show_modified_status = true,     -- Shows indicator when the buffer is modified.

            mode = 0,                        -- 0: Shows buffer name
            -- 1: Shows buffer index
            -- 2: Shows buffer name + buffer index
            -- 3: Shows buffer number
            -- 4: Shows buffer name + buffer number

            max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
            -- it can also be a function that returns
            -- the value of `max_length` dynamically.
            filetype_names = {
              TelescopePrompt = 'Telescope',
              dashboard = 'Dashboard',
              packer = 'Packer',
              fzf = 'FZF',
              alpha = 'Alpha'
            }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

            -- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
            use_mode_colors = false,

            buffers_color = {
              -- Same values as the general color option can be used here.
              active = 'lualine_{section}_normal',     -- Color for active buffer.
              inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
            },

            symbols = {
              modified = ' ●', -- Text to show when the buffer is modified
              alternate_file = '#', -- Text to show to identify the alternate file
              directory = '', -- Text to show when the buffer is a directory
            },
          },
          {
            'datetime',
            -- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
            style = 'default'
          },
          {
            'diagnostics',

            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { 'nvim_diagnostic', 'coc' },

            -- Displays diagnostics for the defined severity types
            sections = { 'error', 'warn', 'info', 'hint' },

            diagnostics_color = {
              -- Same values as the general color option can be used here.
              error = 'DiagnosticError', -- Changes diagnostics' error color.
              warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
              info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
              hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
            },
            symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
            colored = true,           -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false,   -- Show diagnostics even if there are none.
          },
          {
            'diff',
            colored = true, -- Displays a colored diff status if set to true
            diff_color = {
              -- Same color values as the general color option can be used here.
              added    = 'LuaLineDiffAdd',                            -- Changes the diff's added color
              modified = 'LuaLineDiffChange',                         -- Changes the diff's modified color
              removed  = 'LuaLineDiffDelete',                         -- Changes the diff's removed color you
            },
            symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the symbols used by the diff.
            source = nil,                                             -- A function that works as a data source for diff.
            -- It must return a table as such:
            --   { added = add_count, modified = modified_count, removed = removed_count }
            -- or nil on failure. count <= 0 won't be displayed.
          },
          {
            'fileformat',
            symbols = {
              unix = '', -- e712
              dos = '', -- e70f
              mac = '', -- e711
            }
          },
          {
            'filename',
            file_status = true,     -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 0,               -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            -- It can also be a function that returns
            -- the value of `shorting_target` dynamically.
            symbols = {
              modified = '[+]',      -- Text to show when the file is modified.
              readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            }
          },
          {
            'filetype',
            colored = true,             -- Displays filetype icon in color if set to true
            icon_only = false,          -- Display only an icon for filetype
            icon = { align = 'right' }, -- Display filetype icon on the right hand side
            -- icon =    {'X', align='right'}
            -- Icon string ^ in table is ignored in filetype component
          },
          {
            'encoding',
            -- Show '[BOM]' when the file has a byte-order mark
            show_bomb = false,
          },
          {
            'searchcount',
            maxcount = 999,
            timeout = 500,
          },
          {
            'tabs',
            tab_max_length = 40,            -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
            max_length = vim.o.columns / 3, -- Maximum width of tabs component.
            -- Note:
            -- It can also be a function that returns
            -- the value of `max_length` dynamically.
            mode = 0, -- 0: Shows tab_nr
            -- 1: Shows tab_name
            -- 2: Shows tab_nr + tab_name

            path = 0, -- 0: just shows the filename
            -- 1: shows the relative path and shorten $HOME to ~
            -- 2: shows the full path
            -- 3: shows the full path and shorten $HOME to ~

            -- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
            use_mode_colors = false,

            tabs_color = {
              -- Same values as the general color option can be used here.
              active = 'lualine_{section}_normal',     -- Color for active tab.
              inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
            },

            show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
            symbols = {
              modified = '[+]',          -- Text to show when the file is modified.
            },

            fmt = function(name, context)
              -- Show + if buffer is modified in tab
              local buflist = vim.fn.tabpagebuflist(context.tabnr)
              local winnr = vim.fn.tabpagewinnr(context.tabnr)
              local bufnr = buflist[winnr]
              local mod = vim.fn.getbufvar(bufnr, '&mod')

              return name .. (mod == 1 and ' +' or '')
            end
          },
          {
            'windows',
            show_filename_only = true,   -- Shows shortened relative path when set to false.
            show_modified_status = true, -- Shows indicator when the window is modified.

            mode = 0,                    -- 0: Shows window name
            -- 1: Shows window index
            -- 2: Shows window name + window index

            max_length = vim.o.columns * 2 / 3, -- Maximum width of windows component,
            -- it can also be a function that returns
            -- the value of `max_length` dynamically.
            filetype_names = {
              TelescopePrompt = 'Telescope',
              dashboard = 'Dashboard',
              packer = 'Packer',
              fzf = 'FZF',
              alpha = 'Alpha'
            },                                            -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )

            disabled_buftypes = { 'quickfix', 'prompt' }, -- Hide a window if its buffer's type is disabled

            -- Automatically updates active window color to match color of other components (will be overidden if buffers_color is set)
            use_mode_colors = false,

            windows_color = {
              -- Same values as the general color option can be used here.
              active = 'lualine_{section}_normal',     -- Color for active window.
              inactive = 'lualine_{section}_inactive', -- Color for inactive window.
            },
          },
          {
            'lsp_status',
            icon = '', -- f013
            symbols = {
              -- Standard unicode symbols to cycle through for LSP progress:
              spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
              -- Standard unicode symbol for when LSP is done:
              done = '✓',
              -- Delimiter inserted between LSP names:
              separator = ' ',
            },
            -- List of LSP names to ignore (e.g., `null-ls`):
            ignore_lsp = {},
            -- Display the LSP name
            show_name = true,
          },
        },
        lualine_b = { 'branch', 'diff', 'diagnostics', hot, },
        lualine_c = {
          'filename',
          { function() return require('bookmarks').status() end },
          {
            "os.date('%a')",
            'data',
            "require'lsp-status'.status()"
          }
        },
        lualine_x = {
          'encoding',
          'fileformat',
          'filetype',
          {
            require("interestingwords").lualine_get,
            cond = require("interestingwords").lualine_has,
            color = { fg = "#ff9e64" },
          },
          {
            require("music-controls")._statusline,
          },
          {
            require('ecolog.integrations.statusline').lualine(),
          },
          {
            { require("weather.lualine").default_c() },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff9e64" },
            },
            { "lsp_status" },
            { "filesize" },
            { "filetype" },
          },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        lualine_a = { 'buffers' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' }
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },

      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      extensions = {},
    })
    require('lualine').refresh({
      force = true,                                  -- do an immidiate refresh
      scope = 'tabpage',                             -- scope of refresh all/tabpage/window
      place = { 'statusline', 'winbar', 'tabline' }, -- lualine segment ro refresh.
    })

    local custom_fname = require('lualine.components.filename'):extend()
    local highlight = require 'lualine.highlight'
    local default_status_colors = { saved = '#228B22', modified = '#C70039' }

    function custom_fname:init(options)
      custom_fname.super.init(self, options)
      self.status_colors = {
        saved = highlight.create_component_highlight_group(
          { bg = default_status_colors.saved }, 'filename_status_saved', self.options),
        modified = highlight.create_component_highlight_group(
          { bg = default_status_colors.modified }, 'filename_status_modified', self.options),
      }
      if self.options.color == nil then self.options.color = '' end
    end

    function custom_fname:update_status()
      local data = custom_fname.super.update_status(self)
      data = highlight.component_format_highlight(vim.bo.modified
        and self.status_colors.modified
        or self.status_colors.saved) .. data
      return data
    end

    require 'lualine'.setup {
      lualine_c = { custom_fname },
    }
  end
}
