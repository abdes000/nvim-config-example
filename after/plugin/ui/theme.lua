local M = {}

-- Default style
M.border_style = "rounded"
M.border_text_align = "center"
M.popup_size = { width = 60, height = 20 }
M.input_size = { width = 40 }
M.menu_size = { width = 40, height = 12 }

-- Light/Dark palettes
M.palettes = {
    dark = {
        border  = "FloatBorder",
        title   = "Title",
        prompt  = "Question",
        minimap = {
            border     = { fg = "#ffff00" },
            background = { bg = "#1e1e2e" },
            warn       = { fg = "#f9e2af" },
            error      = { fg = "#f38ba8" },
            addition   = { fg = "#a6e3a1" },
            deletion   = { fg = "#f38ba8" },
            underline  = { underline = true, sp = "#89b4fa" },
            bounds_bg  = { bg = "#313244" },
        },
    },
    light = {
        border  = "Normal",
        title   = "Title",
        prompt  = "Question",
        minimap = {
            border     = { fg = "#000000" },
            background = { bg = "#f5f5f5" },
            warn       = { fg = "#d79921" },
            error      = { fg = "#cc241d" },
            addition   = { fg = "#98971a" },
            deletion   = { fg = "#cc241d" },
            underline  = { underline = true, sp = "#458588" },
            bounds_bg  = { bg = "#ebdbb2" },
        },
    },
}

-- Current palette
M.colors = M.palettes.dark

-- Switch palette dynamically
function M.set_palette(mode)
    if mode == "light" then
        M.colors = M.palettes.light
    else
        M.colors = M.palettes.dark
    end

    -- Apply CodeWindow highlights
    local minimap = M.colors.minimap
    vim.api.nvim_set_hl(0, "CodewindowBorder", minimap.border)
    vim.api.nvim_set_hl(0, "CodewindowBackground", minimap.background)
    vim.api.nvim_set_hl(0, "CodewindowWarn", minimap.warn)
    vim.api.nvim_set_hl(0, "CodewindowError", minimap.error)
    vim.api.nvim_set_hl(0, "CodewindowAddition", minimap.addition)
    vim.api.nvim_set_hl(0, "CodewindowDeletion", minimap.deletion)
    vim.api.nvim_set_hl(0, "CodewindowUnderline", minimap.underline)
    vim.api.nvim_set_hl(0, "CodewindowBoundsBackground", minimap.bounds_bg)
end

-- Helper: styled popup
function M.popup(title)
    local Popup = require("nui.popup")
    return Popup({
        enter = true,
        focusable = true,
        border = {
            style = M.border_style,
            text = { top = " " .. title .. " ", top_align = M.border_text_align },
            highlight = M.colors.border,
        },
        position = "50%",
        size = M.popup_size,
    })
end

-- Helper: styled input
function M.input(prompt, on_submit)
    local Input = require("nui.input")
    local input = Input({
        position = "50%",
        size = M.input_size,
        border = {
            style = M.border_style,
            text = { top = " " .. (prompt or "Input") .. " ", top_align = M.border_text_align },
            highlight = M.colors.border,
        },
    }, {
        on_submit = on_submit,
    })
    input:mount()
end

-- Helper: styled menu
function M.menu(prompt, items, on_submit)
    local Menu = require("nui.menu")
    local menu_items = {}
    for _, item in ipairs(items) do
        table.insert(menu_items, Menu.item(item))
    end
    local menu = Menu({
        position = "50%",
        size = M.menu_size,
        border = {
            style = M.border_style,
            text = { top = " " .. (prompt or "Select") .. " ", top_align = M.border_text_align },
            highlight = M.colors.border,
        },
    }, {
        lines = menu_items,
        on_submit = function(item)
            on_submit(item.text)
        end,
    })
    menu:mount()
end

return M
