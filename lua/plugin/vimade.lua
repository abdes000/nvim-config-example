return {
    "tadaa/vimade",
    opts = {
        recipe = { "ripple", { animate = true } },
        fadelevel = 0.4,
        ncmode = 'buffers',
        basebg = '#2d2d2d',
        blocklist = {
            demo_tutorial = function(win, current)
                -- current can be nil
                if (win.win_config.relative == '') and (current and current.win_config.relative ~= '') then
                    return false
                end
                return true
            end,
            default = {
                highlights = {
                    laststatus_3 = function(win, active)
                        if vim.go.laststatus == 3 then
                            return 'StatusLine'
                        end
                    end,
                    'TabLineSel',
                    'Pmenu',
                    'PmenuSel',
                    'PmenuKind',
                    'PmenuKindSel',
                    'PmenuExtra',
                    'PmenuExtraSel',
                    'PmenuSbar',
                    'PmenuThumb',
                },
                buf_opts = { buftype = { 'prompt' } },
            },
            default_block_floats = function(win, active)
                return win.win_config.relative ~= '' and
                    (win ~= active or win.buf_opts.buftype == 'terminal') and true or false
            end,
        },
        tint = {
            fg = { rgb = { 255, 0, 0 }, intensity = 0.5 },
            bg = { rgb = { 0, 0, 0 }, intensity = 0.2 }
        },
        link = {
            my_linked_windows = function(win, active)
                return win.win_vars.linked_window == 1 and active.win_vars.linked_window == 1
            end,
        },
    }
}
