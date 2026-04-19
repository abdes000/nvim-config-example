return {
    "luukvbaal/statuscol.nvim",
    config = function()
        -- local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            -- configuration goes here, for example:
            -- relculright = true,
            -- segments = {
            --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
            --   {
            --     sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
            --     click = "v:lua.ScSa"
            --   },
            --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
            --   {
            --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
            --     click = "v:lua.ScSa"
            --   },
            -- }
        })
        local builtin = require("statuscol.builtin")
        local cfg = {
            setopt = true, -- Whether to set the 'statuscolumn' option, may be set to false for those who
            -- want to use the click handlers in their own 'statuscolumn': _G.Sc[SFL]a().
            -- Although I recommend just using the segments field below to build your
            -- statuscolumn to benefit from the performance optimizations in this plugin.
            -- builtin.lnumfunc number string options
            thousands = false,   -- or line number thousands separator string ("." / ",")
            relculright = false, -- whether to right-align the cursor line number with 'relativenumber' set
            -- Builtin 'statuscolumn' options
            ft_ignore = nil,     -- Lua table with 'filetype' values for which 'statuscolumn' will be unset
            bt_ignore = nil,     -- Lua table with 'buftype' values for which 'statuscolumn' will be unset
            -- Default segments (fold -> sign -> line number + separator), explained below
            segments = {
                { text = { "%C" }, click = "v:lua.ScFa" },
                { text = { "%s" }, click = "v:lua.ScSa" },
                {
                    text = { builtin.lnumfunc, " " },
                    condition = { true, builtin.not_empty },
                    click = "v:lua.ScLa",
                },
                {
                    text = { "%C" },      -- table of strings or functions returning a string
                    click = "v:lua.ScFa", -- %@ click function label, applies to each text element
                    hl = "FoldColumn",    -- %# highlight group label, applies to each text element
                    condition = { true }, -- table of booleans or functions returning a boolean
                    sign = {              -- table of fields that configure a sign segment
                        -- at least one of "name", "text", and "namespace" is required
                        -- legacy signs are matched against the defined sign name e.g. "DapBreakpoint"
                        -- extmark signs can be matched against either the namespace or the sign text itself
                        name = { ".*" },      -- table of Lua patterns to match the legacy sign name against
                        text = { ".*" },      -- table of Lua patterns to match the extmark sign text against
                        namespace = { ".*" }, -- table of Lua patterns to match the extmark sign namespace against
                        -- below values list the default when omitted:
                        maxwidth = 1,         -- maximum number of signs that will be displayed in this segment
                        colwidth = 2,         -- number of display cells per sign in this segment
                        auto = false,         -- boolean or string indicating what will be drawn when no signs
                        -- matching the pattern are currently placed in the buffer.
                        wrap = false,         -- when true, signs in this segment will also be drawn on the
                        -- virtual or wrapped part of a line (when v:virtnum != 0).
                        fillchar = " ",       -- character used to fill a segment with less signs than maxwidth
                        fillcharhl = nil,     -- highlight group used for fillchar (SignColumn/CursorLineSign if omitted)
                        foldclosed = false,   -- when true, show signs from lines in a closed fold on the first line
                    }
                },
                {
                    text = {
                        " ",           -- whitespace padding
                        function(args) -- custom line number highlight function
                            return ((args.lnum % 2 > 0) and "%#DiffDelete#%=" or "%#DiffAdd#%=") .. "%l"
                        end,
                        " ", -- whitespace padding
                    },
                    condition = {
                        true,          -- always shown
                        function(args) -- shown only for the current window
                            return args.actual_curwin == args.win
                        end,
                        builtin.not_empty, -- only shown when the rest of the statuscolumn is not empty
                    },
                },
            },
            clickmod = "c",   -- modifier used for certain actions in the builtin clickhandlers:
            -- "a" for Alt, "c" for Ctrl and "m" for Meta.
            clickhandlers = { -- builtin click handlers, keys are pattern matched
                Lnum                   = builtin.lnum_click,
                FoldClose              = builtin.foldclose_click,
                FoldOpen               = builtin.foldopen_click,
                FoldOther              = builtin.foldother_click,
                DapBreakpointRejected  = builtin.toggle_breakpoint,
                DapBreakpoint          = builtin.toggle_breakpoint,
                DapBreakpointCondition = builtin.toggle_breakpoint,
                ["diagnostic/signs"]   = builtin.diagnostic_click,
                gitsigns               = builtin.gitsigns_click,
            },
            args = {
                lnum = 43, -- v:lnum
                relnum = 5, -- v:relnum
                virtnum = 0, -- v:virtnum
                buf = 1, -- buffer handle of drawn window
                win = 1000, -- window handle of drawn window
                actual_curbuf = 1, -- buffer handle of |g:actual_curwin|
                actual_curwin = 1000, -- window handle of |g:actual_curbuf|
                nu = true, -- 'number' option value
                rnu = true, -- 'relativenumber' option value
                empty = true, -- statuscolumn is currently empty
                fold = {
                    width = 1, -- current width of the fold column
                    -- 'fillchars' option values:
                    close = "", -- foldclose
                    open = "", -- foldopen
                    sep = " " -- foldsep
                },
                -- FFI data:
                -- tick = 251ULL, -- display_tick value
                --   wp = cdata<struct 112 *>: 0x560b56519a50 -- win_T pointer handle
            }
        }
        require("statuscol").setup(cfg, {
            relculright = true,
            segments = {
                -- Line numbers with DAP breakpoint actions
                {
                    text = { builtin.lnumfunc },
                    click = "v:lua.ScLaClick",
                },
                -- Fold column with fold actions
                {
                    text = { builtin.foldfunc },
                    click = "v:lua.ScFaClick",
                },
                -- Diagnostic signs
                {
                    text = { builtin.signfunc },
                    click = "v:lua.ScSaClick",
                },
                -- Git signs
                {
                    text = { builtin.gitsigns },
                    click = "v:lua.ScSaClick",
                },
            },

        })
    end,
}
