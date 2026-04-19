
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Keep search results centered
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Paste without overwriting register
map("v", "p", '"_dP', opts)

-- Quick save & quit
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)

-- Clear search highlights
map("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Toggle spell checking
map("n", "<leader>ss", ":set spell!<CR>", opts)

-- Toggle relative number
map("n", "<leader>rn", ":set relativenumber!<CR>", opts)

-- Toggle wrap
map("n", "<leader>tw", ":set wrap!<CR>", opts)

-- System clipboard integration
map("v", "<leader>y", '"+y', opts)
map("n", "<leader>Y", '"+Y', opts)
map("n", "<leader>p", '"+p', opts)
map("n", "<leader>P", '"+P', opts)

-- Quickfix navigation
map("n", "<C-n>", ":cnext<CR>zz", opts)
map("n", "<C-p>", ":cprev<CR>zz", opts)

-- Location list navigation
map("n", "]l", ":lnext<CR>zz", opts)
map("n", "[l", ":lprev<CR>zz", opts)

-- Toggle file explorer (if using nvim-tree or netrw)
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope shortcuts (if using telescope.nvim)
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

-- LSP keymaps (if using built-in LSP)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
