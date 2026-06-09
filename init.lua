-- Neovim config entry point (NvChad-free, pure Lua + lazy.nvim)

-- leader must be set before loading any plugin
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- load global config
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- bootstrap lazy.nvim and load all plugin specs
require("config.lazy")
