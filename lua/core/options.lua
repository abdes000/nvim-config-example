-- Modern Neovim 0.12.0 options, conflict-free

local opt = vim.opt

-- UI
opt.guicursor = ""
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorcolumn = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.colorcolumn = "100"
opt.scrolloff = 7
opt.sidescrolloff = 0
opt.wrap = false
opt.linebreak = true
opt.showmatch = true
opt.ruler = true
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2
opt.statusline = ""
opt.shortmess:append("c")
opt.lazyredraw = true
opt.redrawtime = 2000

-- Editing
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true
opt.cindent = true
opt.cinwords = { "if", "else", "while", "do", "for", "switch" }
opt.formatoptions = "tcqrn1"
opt.textwidth = 0
opt.virtualedit = "block"
opt.matchpairs:append("<:>")
opt.whichwrap = "b,s,<,>"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/.undodir"
opt.directory = "/tmp//,."
opt.writebackup = false
opt.autoread = true
opt.fileencoding = "utf-8"
opt.fileformat = "unix"
opt.fileformats = { "unix", "dos" }

-- Folding
opt.foldenable = true
opt.foldmethod = "manual"
opt.foldlevel = 0
opt.foldcolumn = "0"
opt.foldtext = "foldtext()"

-- Completion
opt.completeopt = { "menuone", "longest" }
opt.complete:append("kspell")

-- Spelling
opt.spell = true
opt.spelllang = { "en" }

-- Performance
opt.updatetime = 50
opt.timeout = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 0

-- Misc
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.background = "dark"
opt.wildmenu = true
opt.wildmode = { "longest", "list", "full" }
opt.wildignore:append({ "*.pyc", "*_build/*", "**/coverage/*", "**/node_modules/*", "**/android/*", "**/ios/*", "**/.git/*" })
opt.path:append("**")
opt.secure = true
opt.exrc = true
opt.shell = "bash"
opt.hidden = true
opt.errorbells = false
opt.visualbell = true
opt.showmode = false
opt.modelines = 2
opt.verbose = 0
opt.scroll = 7
opt.diffopt = { "internal", "filler", "closeoff" }
opt.list = true
opt.wildoptions = "pum"
opt.breakindent = false
