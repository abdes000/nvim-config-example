return {
    'MunifTanjim/nui.nvim',
    config = function()
        local Popup = require("nui.popup")
        local Layout = require("nui.layout")
        local current_dir = "row"
        local Input = require("nui.input")
        local event = require("nui.utils.autocmd").event

        local popup_one, popup_two = Popup({
            enter = true,
            border = "single",
        }), Popup({
            border = "double",
        })

        local layout = Layout(
            {
                position = "50%",
                size = {
                    width = 80,
                    height = "60%",
                },
            },
            Layout.Box({
                Layout.Box(popup_one, { size = "40%" }),
                Layout.Box(popup_two, { size = "60%" }),
            }, { dir = "row" })
        )


        popup_one:map("n", "r", function()
            if current_dir == "col" then
                layout:update(Layout.Box({
                    Layout.Box(popup_one, { size = "40%" }),
                    Layout.Box(popup_two, { size = "60%" }),
                }, { dir = "row" }))

                current_dir = "row"
            else
                layout:update(Layout.Box({
                    Layout.Box(popup_two, { size = "60%" }),
                    Layout.Box(popup_one, { size = "40%" }),
                }, { dir = "col" }))

                current_dir = "col"
            end
        end, {})

        layout:mount()


        local popup = Popup({
            enter = true,
            focusable = true,
            border = {
                style = "rounded",
            },
            position = "50%",
            size = {
                width = "80%",
                height = "60%",
            },
        })

        -- mount/open the component
        popup:mount()

        -- unmount component when cursor leaves buffer
        popup:on(event.BufLeave, function()
            popup:unmount()
        end)

        -- set content
        -- vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { "Hello World" })
        vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false)

        local input = Input({
            position = "50%",
            size = {
                width = 20,
            },
            border = {
                style = "single",
                text = {
                    top = "[Howdy?]",
                    top_align = "center",
                },
            },
            win_options = {
                winhighlight = "Normal:Normal,FloatBorder:Normal",
            },
        }, {
            prompt = "> ",
            default_value = "Hello",
            on_close = function()
                print("Input Closed!")
            end,
            on_submit = function(value)
                print("Input Submitted: " .. value)
            end,
        })

        -- mount/open the component
        input:mount()

        -- unmount component when cursor leaves buffer
        input:on(event.BufLeave, function()
            input:unmount()
        end)

        local Timer = Popup:extend("Timer")

        function Timer:init(popup_options)
            local options = vim.tbl_deep_extend("force", popup_options or {}, {
                border = "double",
                focusable = false,
                position = { row = 0, col = "100%" },
                size = { width = 10, height = 1 },
                win_options = {
                    winhighlight = "Normal:Normal,FloatBorder:SpecialChar",
                },
            })

            Timer.super.init(self, options)
        end

        function Timer:countdown(time, step, format)
            local function draw_content(text)
                local gap_width = 10 - vim.api.nvim_strwidth(text)
                vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, {
                    string.format(
                        "%s%s%s",
                        string.rep(" ", math.floor(gap_width / 2)),
                        text,
                        string.rep(" ", math.ceil(gap_width / 2))
                    ),
                })
            end

            self:mount()

            local remaining_time = time

            draw_content(format(remaining_time))

            vim.fn.timer_start(step, function()
                remaining_time = remaining_time - step

                draw_content(format(remaining_time))

                if remaining_time <= 0 then
                    self:unmount()
                end
            end, { ["repeat"] = math.ceil(remaining_time / step) })
        end

        local timer = Timer()

        timer:countdown(10000, 1000, function(time)
            return tostring(time / 1000) .. "s"
        end)
    end
}
