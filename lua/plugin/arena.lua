return {
    "dzfrias/arena.nvim",
    event = "BufWinEnter",
    -- Calls `.setup()` automatically
    -- config = true,
    opts = {
        -- Maxiumum number of files that the arena window can contain, or `nil` for
        -- an unlimited amount
        max_items = 5,
        -- Always show the enclosing directory for these paths
        always_context = { "mod.rs", "init.lua" },
        -- When set, ignores the current buffer when listing files in the window.
        ignore_current = false,
        -- Options to apply to the arena buffer.
        buf_opts = {
            -- ["relativenumber"] = false,
        },
        -- Filter out buffers per the project they belong to.
        per_project = false,
        --- Add devicons (from nvim-web-devicons, if installed) to buffers
        devicons = false,


        window = {
            width = 60,
            height = 10,
            border = "rounded",

            -- Options to apply to the arena window.
            opts = {},
        },

        -- Keybinds for the arena window.
        keybinds = {
            -- ["e"] = function()
            --   vim.cmd("echo \"Hello from the arena!\"")
            -- end
        },

        -- Change the way the arena listing looks with custom rendering functions
        renderers = {},

        -- Config for frecency algorithm.
        algorithm = {
            -- Multiplies the recency by a factor. Must be greater than zero.
            -- A smaller number will mean less of an emphasis on recency!
            recency_factor = 0.5,
            -- Same as `recency_factor`, but for frequency!
            frequency_factor = 1,
        },
    },
    keybinds = {
        -- An example keybind that prints the linecount of the buffer of the
        -- current line in the window
        ["i"] = function(win)
            local current = win:current()
            local info = vim.fn.getbufinfo(current.bufnr)[1]
            print(info.linecount)
        end,
    },
    config = function ()
        -- Arena.nvim keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Toggle Arena window
map("n", "<leader>at", function()
  require("arena").toggle()
end, vim.tbl_extend("force", opts, { desc = "Arena Toggle" }))

-- Open Arena window
map("n", "<leader>ao", function()
  require("arena").open()
end, vim.tbl_extend("force", opts, { desc = "Arena Open" }))

-- Close Arena window
map("n", "<leader>ac", function()
  require("arena").close()
end, vim.tbl_extend("force", opts, { desc = "Arena Close" }))

-- Remove buffer from Arena (defaults to current buffer)
map("n", "<leader>ar", function()
  local buf = vim.api.nvim_get_current_buf()
  require("arena").remove(buf)
end, vim.tbl_extend("force", opts, { desc = "Arena Remove buffer" }))

-- Pin buffer to Arena (defaults to current buffer)
map("n", "<leader>ap", function()
  local buf = vim.api.nvim_get_current_buf()
  require("arena").pin(buf)
end, vim.tbl_extend("force", opts, { desc = "Arena Pin buffer" }))

-- Refresh Arena window
map("n", "<leader>af", function()
  require("arena").refresh()
end, vim.tbl_extend("force", opts, { desc = "Arena Refresh" }))

    end
}
