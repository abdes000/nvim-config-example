return {
    "monaqa/dial.nvim",
    config = function()
        vim.keymap.set("n", "<C-a>", function()
            require("dial.map").manipulate("increment", "normal")
        end)
        vim.keymap.set("n", "<C-x>", function()
            require("dial.map").manipulate("decrement", "normal")
        end)
        vim.keymap.set("n", "g<C-a>", function()
            require("dial.map").manipulate("increment", "gnormal")
        end)
        vim.keymap.set("n", "g<C-x>", function()
            require("dial.map").manipulate("decrement", "gnormal")
        end)
        vim.keymap.set("x", "<C-a>", function()
            require("dial.map").manipulate("increment", "visual")
        end)
        vim.keymap.set("x", "<C-x>", function()
            require("dial.map").manipulate("decrement", "visual")
        end)
        vim.keymap.set("x", "g<C-a>", function()
            require("dial.map").manipulate("increment", "gvisual")
        end)
        vim.keymap.set("x", "g<C-x>", function()
            require("dial.map").manipulate("decrement", "gvisual")
        end)


        local augend = require("dial.augend")
        require("dial.config").augends:register_group {
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"],
            },
            only_in_visual = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"],
                augend.constant.alias.alpha,
                augend.constant.alias.Alpha,
            },
        }

        -- Use `only_in_visual` group only in VISUAL <C-a> / <C-x>
        vim.keymap.set("x", "<C-a>", function()
            require("dial.map").manipulate("increment", "visual", "only_in_visual")
        end)
        vim.keymap.set("x", "<C-x>", function()
            require("dial.map").manipulate("decrement", "visual", "only_in_visual")
        end)

        require("dial.config").augends:on_filetype {
            typescript = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.constant.new { elements = { "let", "const" } },
            },
        }

        require("dial.config").augends:register_group {
            default = {
                -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
                augend.integer.new {
                    radix = 16,
                    prefix = "0x",
                    natural = true,
                    case = "upper",
                },
                augend.date.new {
                    pattern = "%Y/%m/%d",
                    default_kind = "day",
                    -- if true, it does not match dates which does not exist, such as 2022/05/32
                    only_valid = true,
                    -- if true, it only matches dates with word boundary
                    word = false,
                },
                -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
                augend.constant.new {
                    elements = { "and", "or" },
                    word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                    cyclic = true, -- "or" is incremented into "and".
                },
                augend.constant.new {
                    elements = { "&&", "||" },
                    word = false,
                    cyclic = true,
                },
                augend.hexcolor.new {
                    case = "upper", -- or "lower", "prefer_upper", "prefer_lower", see below
                },
                augend.user.new {
                    find = require("dial.augend.common").find_pattern("%d+"),
                    add = function(text, addend, cursor)
                        local n = tonumber(text)
                        n = math.floor(n * (2 ^ addend))
                        text = tostring(n)
                        cursor = #text
                        return { text = text, cursor = cursor }
                    end
                },
                
            },
        }
    end
}
