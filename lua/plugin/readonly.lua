return {
  "bgaillard/readonly.nvim",
  dependencies = {
    "rcarriga/nvim-notify", -- Required for the notification display mode
  },
  lazy = false,
  opts = {
    display_modes = {
      notification = {

        --- Whether to enable notifications
        enabled = true,

        --- Default options for "rcarriga/nvim-notify"
        ---
        --- You can override those options to customize the notification.
        ---
        --- see https://github.com/rcarriga/nvim-notify/blob/master/lua/notify/config/init.lua
        opts = {
          level = vim.log.levels.ERROR,
          timeout = 5000,
          max_width = nil,
          max_height = nil,
          stages = "fade_in_slide_out",
          render = "default",
          background_colour = "#000000",
          on_open = nil,
          on_close = nil,
          minimum_width = 50,
          fps = 30,
          top_down = true,
          merge_duplicates = true,
          time_formats = {
            notification_history = "%FT%T",
            notification = "%T",
          },
          icons = {
            ERROR = "",
            WARN = "",
            INFO = "",
            DEBUG = "",
            TRACE = "✎",
          },
        }
      },
      pattern = {
        vim.fn.expand("~") .. "/.aws/config",
        vim.fn.expand("~") .. "/.aws/credentials",
        vim.fn.expand("~") .. "/.ssh/*",
        vim.fn.expand("~") .. "/.secrets.yaml",
        vim.fn.expand("~") .. "/.vault-crypt-files/*",
      }
    },
  },
}
