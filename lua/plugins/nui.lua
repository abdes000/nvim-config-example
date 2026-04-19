return {
    "MunifTanjim/nui.nvim",
    config = function()
        local Popup = require("nui.popup")
        local Input = require("nui.input")
        local Menu = require("nui.menu")

        ----------------------------------------------------------------------
        -- Global overrides: make NUI the default prompt system everywhere
        ----------------------------------------------------------------------
        vim.ui.input = function(opts, on_confirm)
            local input = Input({
                position = "50%",
                size = { width = 40 },
                border = {
                    style = "rounded",
                    text = { top = opts.prompt or "Input", top_align = "center" },
                },
            }, {
                on_submit = function(value)
                    on_confirm(value)
                end,
            })
            input:mount()
        end

        vim.ui.select = function(items, opts, on_choice)
            local menu_items = {}
            for _, item in ipairs(items) do
                table.insert(menu_items, Menu.item(item))
            end

            local menu = Menu({
                position = "50%",
                size = { width = 40, height = 10 },
                border = {
                    style = "single",
                    text = { top = opts.prompt or "Select", top_align = "center" },
                },
            }, {
                lines = menu_items,
                on_submit = function(item)
                    on_choice(item.text, nil)
                end,
            })
            menu:mount()
        end

        ----------------------------------------------------------------------
        -- Demo components: popup, input, menu
        ----------------------------------------------------------------------
        local popup = Popup({
            enter = true,
            focusable = true,
            border = {
                style = "rounded",
                text = { top = " Demo Popup ", top_align = "center" },
            },
            position = "50%",
            size = { width = 60, height = 20 },
        })

        local input_demo = Input({
            position = "50%",
            size = { width = 40 },
            border = {
                style = "single",
                text = { top = " Input Demo ", top_align = "center" },
            },
        }, {
            on_submit = function(value)
                print("Demo input: " .. value)
            end,
        })

        local menu_demo = Menu({
            position = "50%",
            size = { width = 40, height = 10 },
            border = {
                style = "double",
                text = { top = " Menu Demo ", top_align = "center" },
            },
        }, {
            lines = {
                Menu.item("Run Code"),
                Menu.item("Debug"),
                Menu.item("Quit"),
            },
            on_submit = function(item)
                print("Demo menu selected: " .. item.text)
            end,
        })

        ----------------------------------------------------------------------
        -- User commands for demos
        ----------------------------------------------------------------------
        vim.api.nvim_create_user_command("NuiPopup", function() popup:mount() end, {})
        vim.api.nvim_create_user_command("NuiInputDemo", function() input_demo:mount() end, {})
        vim.api.nvim_create_user_command("NuiMenuDemo", function() menu_demo:mount() end, {})

        -- Test global overrides
        vim.keymap.set("n", "<leader>np", function()
            vim.ui.input({ prompt = "Enter something:" }, function(value)
                print("You entered: " .. (value or ""))
            end)
        end, { desc = "NUI: Test input prompt" })

        vim.keymap.set("n", "<leader>ns", function()
            vim.ui.select({ "Option A", "Option B", "Option C" }, { prompt = "Choose:" }, function(choice)
                print("You chose: " .. (choice or ""))
            end)
        end, { desc = "NUI: Test select menu" })

        -- Demo components
        vim.keymap.set("n", "<leader>nP", "<cmd>NuiPopup<cr>", { desc = "NUI: Show demo popup" })
        vim.keymap.set("n", "<leader>nI", "<cmd>NuiInputDemo<cr>", { desc = "NUI: Show demo input" })
        vim.keymap.set("n", "<leader>nM", "<cmd>NuiMenuDemo<cr>", { desc = "NUI: Show demo menu" })

        -- Example: confirm before saving sensitive files
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.env",
            callback = function()
                vim.ui.input({ prompt = "Save .env file? (y/n)" }, function(value)
                    if value ~= "y" then
                        vim.cmd("abort")
                    end
                end)
            end,
        })


        -- Example: log when a prompt closes
        vim.api.nvim_create_autocmd("User", {
            pattern = "NuiInputClose",
            callback = function()
                print("NUI input closed")
            end,
        })

        local theme = require("ui.nui_theme")

        vim.ui.input = function(opts, on_confirm)
            theme.input(opts.prompt, function(value)
                on_confirm(value)
            end)
        end

        vim.ui.select = function(items, opts, on_choice)
            theme.menu(opts.prompt, items, function(choice)
                on_choice(choice, nil)
            end)
        end

        -- Switch palette when colorscheme changes
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                local bg = vim.o.background
                theme.set_palette(bg) -- "dark" or "light"
            end,
        })

        vim.ui.input = function(opts, on_confirm)
            require("ui.nui_theme").input(opts.prompt, function(value)
                on_confirm(value)
            end)
        end

        vim.ui.select = function(items, opts, on_choice)
            require("ui.nui_theme").menu(opts.prompt, items, function(choice)
                on_choice(choice, nil)
            end)
        end


        vim.keymap.set("n", "<leader>np", function()
            vim.ui.input({ prompt = "Enter something:" }, function(value)
                print("You entered: " .. (value or ""))
            end)
        end, { desc = "NUI: Input prompt (themed)" })

        vim.keymap.set("n", "<leader>ns", function()
            vim.ui.select({ "Option A", "Option B", "Option C" }, { prompt = "Choose:" }, function(choice)
                print("You chose: " .. (choice or ""))
            end)
        end, { desc = "NUI: Select menu (themed)" })
    end,
}
