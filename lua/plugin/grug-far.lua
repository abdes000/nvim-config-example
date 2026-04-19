return {
    'MagicDuck/grug-far.nvim',
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
        -- optional setup call to override plugin options
        -- alternatively you can set options with vim.g.grug_far = { ... }
        require('grug-far').setup({
            -- options, see Configuration section below
            -- there are no required options atm
        });
        vim.keymap.set({ 'n', 'x' }, '<leader>ss', function()
            local search = vim.fn.getreg('/')
            -- surround with \b if "word" search (such as when pressing `*`)
            if search and vim.startswith(search, '\\<') and vim.endswith(search, '\\>') then
                search = '\\b' .. search:sub(3, -3) .. '\\b'
            end
            require('grug-far').open({
                prefills = {
                    search = search,
                },
            })
        end, { desc = 'grug-far: Search using @/ register value or visual selection' })

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('my-grug-far-custom-keybinds', { clear = true }),
            pattern = { 'grug-far' },
            callback = function()
                vim.keymap.set('n', '<localleader>w', function()
                    local state = unpack(require('grug-far').get_instance(0):toggle_flags({ '--fixed-strings' }))
                    vim.notify('grug-far: toggled --fixed-strings ' .. (state and 'ON' or 'OFF'))
                end, { buffer = true })
            end,
        })

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('grug-far-keybindings', { clear = true }),
            pattern = { 'grug-far' },
            callback = function()
                vim.keymap.set('n', '<C-enter>', function()
                    require('grug-far').get_instance(0):open_location()
                    require('grug-far').get_instance(0):close()
                end, { buffer = true })
            end,
        })

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('grug-far-keymap', { clear = true }),
            pattern = { 'grug-far' },
            callback = function()
                -- jump back to first input by hitting left arrow in normal mode:
                vim.keymap.set('n', '<left>', function()
                    require('grug-far').get_instance(0):goto_first_input()
                end, { buffer = true })
            end,
        })
    end
}
