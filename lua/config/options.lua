-- Editor options
local opt = vim.opt
local o = vim.o

o.termguicolors = true

-- visual feedback
o.cmdheight = 1
o.conceallevel = 0
o.pumheight = 10
o.showtabline = 2
o.smarttab = true
o.wrap = true

o.relativenumber = false
o.number = true
o.sidescrolloff = 8
opt.scrolloff = 8

-- folding: indent method but fully expanded by default (almost never auto-folds)
opt.foldmethod = "indent"
opt.foldlevel = 99

opt.swapfile = false

-- system clipboard
opt.clipboard = "unnamedplus"

-- indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = false

-- invisible characters
opt.list = true
opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "◣",
  precedes = "◢",
  nbsp = "○",
}

-- completion
opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append("c")

-- search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- window split direction
opt.splitbelow = true
opt.splitright = true

-- persistent undo (works with undotree)
opt.undofile = true

-- auto-session: sessionoptions includes localoptions to correctly restore session-local options
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
