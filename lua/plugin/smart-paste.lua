return -- lazy.nvim
{
    'nemanjamalesija/smart-paste.nvim',
    event = 'VeryLazy',
    config = function()
        require('smart-paste').setup()
        vim.keymap.set('n', '<M-p>', function()
            require('smart-paste').paste({ register = '+', key = 'p' })
        end, { desc = 'Smart paste from system clipboard' })

        vim.keymap.set('n', '<leader>p', '<Plug>(smart-paste-raw-p)')
        vim.keymap.set('n', '<leader>P', '<Plug>(smart-paste-raw-P)')
    end,
}
