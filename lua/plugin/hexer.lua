return {
    "theKnightsOfRohan/hexer.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        ---@class HexerConverter
        ---@field accessor_key string                       Required for nui tables, can be similar to header
        ---@field header string                             The title of the field as seen in the table
        ---@field is_type fun(str: string): boolean         Whether or not a given string can be parsed by your format
        ---@field to_value fun(str: string): integer        Convert from your format to an integer value
        ---@field from_value fun(value: integer): string    Convert from an integer value to your format.
        ---@class HexerConfig
        ---@field converters HexerConverter[]
        ---@field popup_opts nui_popup_options
        ---@field table_opts nui_table_options
        local config = {
            converters = {}, -- This array will be appended onto the hexer default converter list
            popup_opts = {
                enter = true,
                focusable = true,
                anchor = "SE",
                border = {
                    style = "none",
                },
                position = {
                    row = "100%",
                    col = "100%",
                },
                size = {
                    width = 420,
                    height = 69,
                },
                buf_options = {
                    buftype = "nofile",
                    buflisted = false,
                    modifiable = false,
                },
            },
            ---@diagnostic disable-next-line: missing-fields
            table_opts = {
                bufnr = 0,
                ns_id = "HexerWindow",
            },
        }
        local hexer = require("hexer")

        hexer:setup(config)

        -- Put your keymaps here...
        -- open() parses the passed string arg and opens the hexer buffer, with nil or an empty string representing retaining the past table.
        hexer:open(arg)
        -- close() is how the hexer buffer closes normally. Useful if you want to remap your own close keys.
        -- Note that a BufLeave autocmd is already set for if you leave hexer or open another buffer with it open.
        hexer:close()
    end,
}
