return {
  "onsails/lspkind.nvim",
  config = function()
    -- setup() is also available as an alias
    require('lspkind').init({
      -- defines how annotations are shown
      -- default: symbol
      -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      mode = 'symbol_text',

      -- default symbol map
      -- can be either 'default' (requires nerd-fonts font) or
      -- 'codicons' for codicon preset (requires vscode-codicons font)
      --
      -- default: 'default'
      preset = 'codicons',

      -- override preset symbols
      --
      -- default: {}
      symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
        Copilot = "",
      },
    })

    local lspkind = require('lspkind')
    cmp.setup {

      sources = {
        { name = 'cmp_tabnine' },
      },
      formatting = {
        {
          fields = { 'abbr', 'icon', 'kind', 'menu' },
          format = lspkind.cmp_format({
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50,            -- leading text (labelDetails)
              abbr = 50,            -- actual suggestion item
            },
            ellipsis_char = '...',  -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              -- ...
              return vim_item
            end
          })
        },
        format = function(entry, vim_item)
          -- if you have lspkind installed, you can use it like
          -- in the following line:
          vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
          vim_item.menu = source_mapping[entry.source.name]
          if entry.source.name == "cmp_tabnine" then
            local detail = (entry.completion_item.labelDetails or {}).detail
            vim_item.kind = ""
            if detail and detail:find('.*%%.*') then
              vim_item.kind = vim_item.kind .. ' ' .. detail
            end

            if (entry.completion_item.data or {}).multiline then
              vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
            end
          end
          local maxwidth = 80
          vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
          return vim_item
        end,
      },
    }
  end
}
