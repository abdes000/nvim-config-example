-- =========================
-- Autocommands
-- =========================
local augroup = vim.api.nvim_create_augroup("TelescopeExtensionsEvents", { clear = true })

vim.api.nvim_create_autocmd("User", {
  group = augroup,
  pattern = "TelescopeFindPre",
  callback = function()
    vim.notify("Opening Telescope extension…", vim.log.levels.INFO)
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = augroup,
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.cmd("setlocal wrap")
    vim.notify("Extension previewer loaded", vim.log.levels.INFO)
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = augroup,
  pattern = "TelescopeResumePost",
  callback = function()
    vim.notify("Resumed Telescope extension session", vim.log.levels.INFO)
  end,
})



local telescopeThemes = require('telescope.themes')

vim.api.nvim_create_user_command('BoxDrawing', function()
  telescope.extensions['box-drawing']['box-drawing'](
    telescopeThemes.get_cursor({
      layout_config = { height = 20, width = 40 },
    })
  )
end, { desc = 'telescope box drawing characters' })

-- -- Before Telescope creates floating windows
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "TelescopeFindPre",
--     callback = function()
--         -- Example: clear messages or set highlights
--         vim.notify("Telescope is about to open…", vim.log.levels.INFO)
--     end,
-- })

-- -- After Telescope previewer window is created
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "TelescopePreviewerLoaded",
--     callback = function()
--         -- Example: enable wrap in previewer
--         vim.cmd("setlocal wrap")
--         vim.notify("Previewer loaded", vim.log.levels.INFO)
--     end,
-- })

-- -- After Telescope resume action is completed
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "TelescopeResumePost",
--     callback = function()
--         -- Example: notify or run custom logic
--         vim.notify("Resumed previous Telescope session", vim.log.levels.INFO)
--     end,
-- })

-- vim.api.nvim_create_autocmd("User", {
--     pattern = "TelescopePreviewerLoaded",
--     callback = function(args)
--         if args.data.filetype ~= "help" then
--             vim.wo.number = true
--         elseif args.data.bufname:match("*.csv") then
--             vim.wo.wrap = false
--         end
--     end,
-- })
