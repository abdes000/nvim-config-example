return {
    'kobbikobb/move-lines.nvim',
    config = function()
        require('move-lines').setup({
            move_down = '<C-J>', -- Custom key for moving lines down
            move_up = '<C-K>', -- Custom key for moving lines up
            move_left = '<C-H>', -- Custom key for moving lines left
            move_right = '<C-L>' -- Custom key for moving lines right
        })
    end,
}
