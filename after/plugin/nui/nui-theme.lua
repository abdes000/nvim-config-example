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
    border = "FloatBorder",
    title  = "Title",
    prompt = "Question",
  },
  light = {
    border = "Normal",
    title  = "Title",
    prompt = "Question",
  },
}

-- Current palette
M.colors = M.palettes.dark

-- Switch theme dynamically
function M.set_palette(mode)
  if mode == "light" then
    M.colors = M.palettes.light
  else
    M.colors = M.palettes.dark
  end
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