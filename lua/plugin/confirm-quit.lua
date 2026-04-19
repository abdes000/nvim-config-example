return {
    "yutkat/confirm-quit.nvim",
    event = "CmdlineEnter",
    opts = {
        overwrite_q_command = true,            -- Replaces :q and :qa with :ConfirmQuit and :ConfirmQuitAll
        quit_message = 'Do you want to quit?', -- Message to show when quitting, can be a function returning a string
    },
    config = function()
        vim.keymap.set("n", "<leader>q", require "confirm-quit".confirm_quit)
        vim.keymap.set("n", "<leader>Q", require "confirm-quit".confirm_quit_all)
    end
}
