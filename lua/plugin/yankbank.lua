return {
    "ptdewey/yankbank-nvim",
    dependencies = {
        "folke/snacks.nvim", -- (optional) - snacks picker integration
    },
    config = function()
        require('yankbank').setup({
            max_entries = 9,
            sep = "-----",
            num_behavior = "jump",
            focus_gain_poll = true,
            persist_type = "sqlite",
            keymaps = {
                paste = "<CR>",
                paste_back = "P",
            },
            registers = {
                yank_register = "+",
            },
            bind_indices = "<leader>p",
            pickers = {
                snacks = true,
            },
        })
    end,
}
