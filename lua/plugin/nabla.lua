return {

  -- {
  "jbyuki/nabla.nvim",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = { ensure_installed = { "tree-sitter-cli" } },
    },
    "nvim-neo-tree/neo-tree.nvim",
    "williamboman/mason.nvim",
  },
  lazy = true,

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "latex" },
      auto_install = true,
      sync_install = false,
    })
    require "nabla".enable_virt({
      autogen = true,           -- auto-regenerate ASCII art when exiting insert mode
      silent = true,            -- silents error messages
    })
  end,
  keys = { function()
    return {
      {
        "<leader>p",
        ':lua require("nabla").popup()<cr>',
        desc = "NablaPopUp",
      },
    }
  end, },
  { "<leader>ps", function() require("nabla").popup({ border = "single" }) end,  desc = "Nabla: Popup (single border)" },
  { "<leader>pd", function() require("nabla").popup({ border = "double" }) end,  desc = "Nabla: Popup (double border)" },
  { "<leader>pr", function() require("nabla").popup({ border = "rounded" }) end, desc = "Nabla: Popup (rounded border)" },


  -- },

}
