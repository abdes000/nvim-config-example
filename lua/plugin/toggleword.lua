return {
    "iquzart/toggleword.nvim",
    opts = {
        key = "<leader>tt" -- optional, defaults to <leader>tt,
    },
    config = function()
        require("toggleword").setup {
            key = "<leader>tw",
            toggle_groups = {
                { "start",  "stop" },
                { "open",   "close" },
                { "active", "inactive" },
            }
        }
    end
}
