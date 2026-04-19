return {
    "moyiz/command-and-cursor.nvim",
    event = "VeryLazy",
    opts = {
        hl_group = "TermCursor", -- The highlight group to use.
        hl_priority = 300, -- Priority of highlight
        inclusive = true,  -- Highlight cursor with visual selection.
        debug_position = false, -- Show start and end positions with `vim.notify`.
    },
}
