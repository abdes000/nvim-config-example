-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup("plugins")

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  defaults = {
    lazy = true, -- load plugins lazily by default
  },
  install = {
    colorscheme = { "tokyonight", "gruvbox" },
  },
  checker = { enabled = true },
  ui = {
    border = "rounded",
  },
  spec = {
    -- import your plugins
    -- { import = "core" },
    { import = "core" },
    { import = "plugins" }, -- this will recursively load lua/plugins/**/*
  },
})
require("lazy").setup("plugins")
