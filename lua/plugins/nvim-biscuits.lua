return {
  'code-biscuits/nvim-biscuits',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    -- Config goes here
  },
  keys = {
      {
        "<leader>bb",
        function()
          local nvim_biscuits =
              require("nvim-biscuits")
          nvim_biscuits.BufferAttach()
          nvim_biscuits.toggle_biscuits()
        end,
        mode = "n",
        desc = "Enable Biscuits",
      },
  },
  config = function()
    require('nvim-biscuits').setup({
      default_config = {
        max_length = 12,
        min_distance = 5,
        prefix_string = " 📎 "
      },
      toggle_keybind = "<leader>cb",
      show_on_start = true,       -- defaults to false
      max_file_size = '100kb',
      language_config = {
        html = {
          prefix_string = " 🌐 "
        },
        javascript = {
          prefix_string = " ✨ ",
          max_length = 80
        },
        python = {
          disabled = true
        },
        on_events = { 'InsertLeave', 'CursorHoldI' }
      }
    })
  end
}
