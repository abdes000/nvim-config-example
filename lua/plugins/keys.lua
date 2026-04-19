return {
    "gbprod/yanky.nvim",
    config = function()
        local wk = require("which-key")

        ----------------------------------------------------------------------
        -- Register Yanky keymaps with which-key
        ----------------------------------------------------------------------
        wk.register({
            ["<leader>y"] = {
                name  = "+yanky",

                -- Put After
                a     = { "<Plug>(YankyPutAfter)", "Put after" },
                ab    = { "<Plug>(YankyPutAfterBlockwise)", "Put after blockwise" },
                abj   = { "<Plug>(YankyPutAfterBlockwiseJoined)", "Put after blockwise joined" },
                ac    = { "<Plug>(YankyPutAfterCharwise)", "Put after charwise" },
                acj   = { "<Plug>(YankyPutAfterCharwiseJoined)", "Put after charwise joined" },
                af    = { "<Plug>(YankyPutAfterFilter)", "Put after filter" },
                afj   = { "<Plug>(YankyPutAfterFilterJoined)", "Put after filter joined" },
                aj    = { "<Plug>(YankyPutAfterJoined)", "Put after joined" },
                al    = { "<Plug>(YankyPutAfterLinewise)", "Put after linewise" },
                alj   = { "<Plug>(YankyPutAfterLinewiseJoined)", "Put after linewise joined" },
                asl   = { "<Plug>(YankyPutAfterShiftLeft)", "Put after shift left" },
                aslj  = { "<Plug>(YankyPutAfterShiftLeftJoined)", "Put after shift left joined" },
                asr   = { "<Plug>(YankyPutAfterShiftRight)", "Put after shift right" },
                asrj  = { "<Plug>(YankyPutAfterShiftRightJoined)", "Put after shift right joined" },

                -- Put Before
                b     = { "<Plug>(YankyPutBefore)", "Put before" },
                bb    = { "<Plug>(YankyPutBeforeBlockwise)", "Put before blockwise" },
                bbj   = { "<Plug>(YankyPutBeforeBlockwiseJoined)", "Put before blockwise joined" },
                bc    = { "<Plug>(YankyPutBeforeCharwise)", "Put before charwise" },
                bcj   = { "<Plug>(YankyPutBeforeCharwiseJoined)", "Put before charwise joined" },
                bf    = { "<Plug>(YankyPutBeforeFilter)", "Put before filter" },
                bfj   = { "<Plug>(YankyPutBeforeFilterJoined)", "Put before filter joined" },
                bj    = { "<Plug>(YankyPutBeforeJoined)", "Put before joined" },
                bl    = { "<Plug>(YankyPutBeforeLinewise)", "Put before linewise" },
                blj   = { "<Plug>(YankyPutBeforeLinewiseJoined)", "Put before linewise joined" },
                bsl   = { "<Plug>(YankyPutBeforeShiftLeft)", "Put before shift left" },
                bslj  = { "<Plug>(YankyPutBeforeShiftLeftJoined)", "Put before shift left joined" },
                bsr   = { "<Plug>(YankyPutBeforeShiftRight)", "Put before shift right" },
                bsrj  = { "<Plug>(YankyPutBeforeShiftRightJoined)", "Put before shift right joined" },

                -- Global Put After
                ga    = { "<Plug>(YankyGPutAfter)", "Global put after" },
                gab   = { "<Plug>(YankyGPutAfterBlockwise)", "Global put after blockwise" },
                gabj  = { "<Plug>(YankyGPutAfterBlockwiseJoined)", "Global put after blockwise joined" },
                gac   = { "<Plug>(YankyGPutAfterCharwise)", "Global put after charwise" },
                gacj  = { "<Plug>(YankyGPutAfterCharwiseJoined)", "Global put after charwise joined" },
                gaf   = { "<Plug>(YankyGPutAfterFilter)", "Global put after filter" },
                gafj  = { "<Plug>(YankyGPutAfterFilterJoined)", "Global put after filter joined" },
                gaj   = { "<Plug>(YankyGPutAfterJoined)", "Global put after joined" },
                gal   = { "<Plug>(YankyGPutAfterLinewise)", "Global put after linewise" },
                galj  = { "<Plug>(YankyGPutAfterLinewiseJoined)", "Global put after linewise joined" },
                gasl  = { "<Plug>(YankyGPutAfterShiftLeft)", "Global put after shift left" },
                gaslj = { "<Plug>(YankyGPutAfterShiftLeftJoined)", "Global put after shift left joined" },
                gasr  = { "<Plug>(YankyGPutAfterShiftRight)", "Global put after shift right" },
                gasrj = { "<Plug>(YankyGPutAfterShiftRightJoined)", "Global put after shift right joined" },

                -- Global Put Before
                gb    = { "<Plug>(YankyGPutBefore)", "Global put before" },
                gbb   = { "<Plug>(YankyGPutBeforeBlockwise)", "Global put before blockwise" },
                gbbj  = { "<Plug>(YankyGPutBeforeBlockwiseJoined)", "Global put before blockwise joined" },
                gbc   = { "<Plug>(YankyGPutBeforeCharwise)", "Global put before charwise" },
                gbcj  = { "<Plug>(YankyGPutBeforeCharwiseJoined)", "Global put before charwise joined" },
                gbf   = { "<Plug>(YankyGPutBeforeFilter)", "Global put before filter" },
                gbfj  = { "<Plug>(YankyGPutBeforeFilterJoined)", "Global put before filter joined" },
                gbj   = { "<Plug>(YankyGPutBeforeJoined)", "Global put before joined" },
                gbl   = { "<Plug>(YankyGPutBeforeLinewise)", "Global put before linewise" },
                gblj  = { "<Plug>(YankyGPutBeforeLinewiseJoined)", "Global put before linewise joined" },
                gbsl  = { "<Plug>(YankyGPutBeforeShiftLeft)", "Global put before shift left" },
                gbslj = { "<Plug>(YankyGPutBeforeShiftLeftJoined)", "Global put before shift left joined" },
                gbsr  = { "<Plug>(YankyGPutBeforeShiftRight)", "Global put before shift right" },
                gbsrj = { "<Plug>(YankyGPutBeforeShiftRightJoined)", "Global put before shift right joined" },

                -- Indented Put After
                ia    = { "<Plug>(YankyPutIndentAfter)", "Indent put after" },
                iab   = { "<Plug>(YankyPutIndentAfterBlockwise)", "Indent put after blockwise" },
                iabj  = { "<Plug>(YankyPutIndentAfterBlockwiseJoined)", "Indent put after blockwise joined" },
                iac   = { "<Plug>(YankyPutIndentAfterCharwise)", "Indent put after charwise" },
                iacj  = { "<Plug>(YankyPutIndentAfterCharwiseJoined)", "Indent put after charwise joined" },
                iaf   = { "<Plug>(YankyPutIndentAfterFilter)", "Indent put after filter" },
                iafj  = { "<Plug>(YankyPutIndentAfterFilterJoined)", "Indent put after filter joined" },
                iaj   = { "<Plug>(YankyPutIndentAfterJoined)", "Indent put after joined" },
                ial   = { "<Plug>(YankyPutIndentAfterLinewise)", "Indent put after linewise" },
                ialj  = { "<Plug>(YankyPutIndentAfterLinewiseJoined)", "Indent put after linewise joined" },
                iasl  = { "<Plug>(YankyPutIndentAfterShiftLeft)", "Indent put after shift left" },
                iaslj = { "<Plug>(YankyPutIndentAfterShiftLeftJoined)", "Indent put after shift left joined" },
                iasr  = { "<Plug>(YankyPutIndentAfterShiftRight)", "Indent put after shift right" },
                iasrj = { "<Plug>(YankyPutIndentAfterShiftRightJoined)", "Indent put after shift right joined" },

                -- Indented Put Before
                ib    = { "<Plug>(YankyPutIndentBefore)", "Indent put before" },
                ibb   = { "<Plug>(YankyPutIndentBeforeBlockwise)", "Indent put before blockwise" },
                ibbj  = { "<Plug>(YankyPutIndentBeforeBlockwiseJoined)", "Indent put before blockwise joined" },
                ibc   = { "<Plug>(YankyPutIndentBeforeCharwise)", "Indent put before charwise" },
                ibcj  = { "<Plug>(YankyPutIndentBeforeCharwiseJoined)", "Indent put before charwise joined" },
                ibf   = { "<Plug>(YankyPutIndentBeforeFilter)", "Indent put before filter" },
                ibfj  = { "<Plug>(YankyPutIndentBeforeFilterJoined)", "Indent put before filter joined" },
                ibj   = { "<Plug>(YankyPutIndentBeforeJoined)", "Indent put before joined" },
                ibl   = { "<Plug>(YankyPutIndentBeforeLinewise)", "Indent put before linewise" },
                iblj  = { "<Plug>(YankyPutIndentBeforeLinewiseJoined)", "Indent put before linewise joined" },
                ibsl  = { "<Plug>(YankyPutIndentBeforeShiftLeft)", "Indent put before shift left" },
                ibslj = { "<Plug>(YankyPutIndentBeforeShiftLeftJoined)", "Indent put before shift left joined" },
                ibsr  = { "<Plug>(YankyPutIndentBeforeShiftRight)", "Indent put before shift right" },
                ibsrj = { "<Plug>(YankyPutIndentBeforeShiftRightJoined)", "Indent put before shift right joined" },
            },
        })
    end,
}
