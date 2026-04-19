return {
  "y3owk1n/time-machine.nvim",
  cmd = {
    "TimeMachineToggle",
    "TimeMachinePurgeBuffer",
    "TimeMachinePurgeAll",
    "TimeMachineLogShow",
    "TimeMachineLogClear",
  },
  opts = {
    {
      split_opts = {
        split = "left",         -- where to open the tree panel
        width = 50,             -- columns number
      },
      float_opts = {
        width = 0.8,          -- between 0 and 1
        height = 0.8,         -- between 0 and 1
        winblend = 0,
      },
      diff_tool = "native",       -- default diff engine
      native_diff_opts = {        -- only used when diff_tool is "native"
        result_type = "unified",
        ctxlen = 3,
        algorithm = "histogram",
      },
      external_diff_args = {},       -- set additional arguments for external diff tools
      keymaps = {
        undo = "u",
        redo = "<C-r>",
        restore_undopoint = "<CR>",
        refresh_timeline = "r",
        preview_sequence_diff = "p",
        tag_sequence = "t",
        close = "q",
        help = "g?",
        toggle_current_timeline = "c",
      },
      ignore_filesize = nil,       -- e.g. 10 * 1024 * 1024
      ignored_filetypes = {
        "terminal",
        "nofile",
        "time-machine-list",
        "mason",
        "snacks_picker_list",
        "snacks_picker_input",
        "snacks_dashboard",
        "snacks_notif_history",
        "lazy",
      },
      time_format = "relative",       -- "pretty"|"relative"|"unix"
      log_level = vim.log.levels.WARN,
      log_file = vim.fn.stdpath("cache") .. "/time-machine.log",
    }
  },
  keys = {
    {
      "<leader>t",
      "",
      desc = "Time Machine",
    },
    {
      "<leader>tt",
      "<cmd>TimeMachineToggle<cr>",
      desc = "[Time Machine] Toggle Tree",
    },
    {
      "<leader>tx",
      "<cmd>TimeMachinePurgeCurrent<cr>",
      desc = "[Time Machine] Purge current",
    },
    {
      "<leader>tX",
      "<cmd>TimeMachinePurgeAll<cr>",
      desc = "[Time Machine] Purge all",
    },
    {
      "<leader>tl",
      "<cmd>TimeMachineLogShow<cr>",
      desc = "[Time Machine] Show log",
    },
  },
  config = function()
    ---@alias TimeMachine.DiffTool "native"|TimeMachine.DiffToolExternal
    ---@alias TimeMachine.DiffToolExternal "difft"|"diff"|"delta"
    ---@alias TimeMachine.SplitDirection 'left'|'right'

    ---@class TimeMachine.Config
    ---@field diff_tool? TimeMachine.DiffTool The diff tool to use
    ---@field native_diff_opts? vim.diff.Opts The options for vim.diff
    ---@field external_diff_args? table<TimeMachine.DiffToolExternal, string[]> The arguments for external diff tools
    ---@field ignore_filesize? integer|nil The file size to ignore undo saved to disk
    ---@field ignored_filetypes? string[] The file types to ignore undo saved to disk
    ---@field split_opts? TimeMachine.Config.SplitOpts The split options
    ---@field float_opts? TimeMachine.Config.FloatOpts The floating window options
    ---@field keymaps? TimeMachine.Config.Keymaps The keymaps for actions
    ---@field time_format? "pretty"|"relative"|"unix" The time format to display
    ---@field log_level? integer The log level
    ---@field log_file? string The log file path

    ---@class TimeMachine.Config.Keymaps
    ---@field undo? string The keymap to undo
    ---@field redo? string The keymap to redo
    ---@field restore_undopoint? string The keymap to restore the undopoint
    ---@field refresh_timeline? string The keymap to refresh the timeline
    ---@field preview_sequence_diff? string The keymap to preview the sequence diff
    ---@field tag_sequence? string The keymap to tag the sequence
    ---@field close? string The keymap to close the timeline
    ---@field help? string The keymap to show the help
    ---@field toggle_current_timeline? string The keymap to toggle to only show the current timeline

    ---@class TimeMachine.Config.SplitOpts
    ---@field split? TimeMachine.SplitDirection The split direction
    ---@field width? integer The width of the split

    ---@class TimeMachine.Config.FloatOpts
    ---@field width? integer The width of the window
    ---@field height? integer The height of the window
    ---@field winblend? integer The winblend of the window
    ---@type TimeMachine.Config

    vim.opt.undofile = true                           -- Enable persistent undo
    vim.opt.undodir = vim.fn.expand("~/.undodir")     -- Set custom undo directory
  end
}
