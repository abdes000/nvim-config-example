return {
    "MisanthropicBit/decipher.nvim",
    keys = {
        -- Encode/Decode with Base64
        { "<leader>de", function() require("decipher").encode("base64") end,   desc = "Decipher: Encode selection (Base64)" },
        { "<leader>dd", function() require("decipher").decode("base64") end,   desc = "Decipher: Decode selection (Base64)" },

        -- Encode/Decode with Base32
        { "<leader>dE", function() require("decipher").encode("base32") end,   desc = "Decipher: Encode selection (Base32)" },
        { "<leader>dD", function() require("decipher").decode("base32") end,   desc = "Decipher: Decode selection (Base32)" },

        -- URL encoding/decoding
        { "<leader>du", function() require("decipher").encode("url") end,      desc = "Decipher: Encode selection (URL)" },
        { "<leader>dU", function() require("decipher").decode("url") end,      desc = "Decipher: Decode selection (URL)" },

        -- XML escaping/unescaping
        { "<leader>dx", function() require("decipher").encode("xml") end,      desc = "Decipher: Escape selection (XML)" },
        { "<leader>dX", function() require("decipher").decode("xml") end,      desc = "Decipher: Unescape selection (XML)" },

        -- Z-base32
        { "<leader>dz", function() require("decipher").encode("z-base32") end, desc = "Decipher: Encode selection (z-base32)" },
        { "<leader>dZ", function() require("decipher").decode("z-base32") end, desc = "Decipher: Decode selection (z-base32)" },

        -- Dynamic prompt for codec
        {
            "<leader>d?",
            function()
                local codec = vim.fn.input("Decipher codec (e.g. base64, url, xml): ")
                if codec ~= "" then
                    local action = vim.fn.input("Encode or decode [e/d]: ")
                    if action == "e" then
                        require("decipher").encode(codec)
                    elseif action == "d" then
                        require("decipher").decode(codec)
                    else
                        print("Invalid action, use 'e' or 'd'")
                    end
                else
                    print("No codec provided")
                end
            end,
            desc = "Decipher: Prompt for codec (encode/decode)",
        },
        -- Visual-mode mappings (apply to selection)
        { "<leader>ve", function() require("decipher").encode("base64") end, mode = "v", desc = "Decipher: Encode selection (Base64)" },
        { "<leader>vd", function() require("decipher").decode("base64") end, mode = "v", desc = "Decipher: Decode selection (Base64)" },
        {
            "<leader>v?",
            function()
                local codec = vim.fn.input("Decipher codec for selection: ")
                if codec ~= "" then
                    local action = vim.fn.input("Encode or decode [e/d]: ")
                    if action == "e" then
                        require("decipher").encode(codec)
                    elseif action == "d" then
                        require("decipher").decode(codec)
                    else
                        print("Invalid action, use 'e' or 'd'")
                    end
                else
                    print("No codec provided")
                end
            end,
            mode = "v",
            desc = "Decipher: Prompt for codec (selection)",
        },

    },

    config = function()
        require("decipher").setup({
            float = {      -- Floating window options
                border = { -- Floating window border
                    { "╭", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╮", "FloatBorder" },
                    { "│", "FloatBorder" },
                    { "╯", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╰", "FloatBorder" },
                    { "│", "FloatBorder" },
                },
                mappings = {
                    -- Close the floating window
                    close = "q",
                    -- Apply the encoding/decoding in the preview to the original buffer
                    apply = "<leader>a",
                    -- Update the original buffer with changes made in the encoded/decoded preview
                    -- keeping the text encoded/decoded
                    update = "<leader>u",
                    -- Prettily format contents as json if possible
                    json = "<leader>j",
                    -- Toggle help
                    help = "g?",
                },
                -- Display a title with the codec name
                title = true,
                -- Position of the title
                title_pos = "left",
                -- Autoclose floating window if insert mode is activated or the cursor
                -- is moved
                autoclose = true,
                -- Automatically open the json view if the contents is valid json
                autojson = false,
                -- Automatically enter the floating window if opened
                enter = false,
                -- Options to apply to the floating window contents
                win_options = {},
                -- Z-index of the floating preview
                zindex = 50,
            },
        })
    end
}
