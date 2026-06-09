-- Custom highlight overrides and additions (catppuccin mocha).
--
-- Colors are resolved from config.palette (catppuccin mocha palette + custom shades)
-- inside apply(), which the ColorScheme autocmd in config.autocmds runs after the theme
-- loads, so these overrides are re-applied on top of catppuccin.
--
-- To find highlight group names: :Telescope highlights
local palette = require("config.palette")

local M = {}

-- Build the override + add tables for the currently active flavour.
local function build()
  local c = palette.get() -- catppuccin colors + custom UI shades for the active flavour

  -- Don't override Normal here — transparency is handled by the autocmd in config.autocmds.
  local override = {
    CursorLine = { bg = c.cursor_line },
    Comment = { fg = c.blue, italic = true },

    -- vibrant syntax
    Keyword = { fg = c.mauve, bold = true },
    Function = { fg = c.blue, bold = true },
    String = { fg = c.green },
    Number = { fg = c.peach },
    Boolean = { fg = c.red },
    Type = { fg = c.yellow, bold = true },
    Constant = { fg = c.peach },
    Variable = { fg = c.text },
    Operator = { fg = c.sky },
    Special = { fg = c.flamingo },
    PreProc = { fg = c.teal },
    Identifier = { fg = c.text },

    Folded = { bg = c.cursor_line, fg = c.subtext1 },
    Search = { bg = c.yellow, fg = c.base },
    IncSearch = { bg = c.blue, fg = c.base },
    Terminal = { bg = c.terminal_bg, fg = c.text },

    -- transparent sign column / line numbers
    SignColumn = { bg = "NONE" },
    LineNrAbove = { bg = "NONE" },
    LineNrBelow = { bg = "NONE" },
  }

  local add = {
    NvimTreeOpenedFolderName = { fg = c.green, bold = true },

    -- treesitter groups
    ["@keyword"] = { fg = c.mauve, bold = true },
    ["@function"] = { fg = c.blue, bold = true },
    ["@function.call"] = { fg = c.blue },
    ["@method"] = { fg = c.blue, bold = true },
    ["@method.call"] = { fg = c.blue },
    ["@string"] = { fg = c.green },
    ["@string.regex"] = { fg = c.yellow },
    ["@number"] = { fg = c.peach },
    ["@boolean"] = { fg = c.red },
    ["@type"] = { fg = c.yellow, bold = true },
    ["@type.builtin"] = { fg = c.yellow },
    ["@constant"] = { fg = c.peach },
    ["@constant.builtin"] = { fg = c.peach, bold = true },
    ["@variable"] = { fg = c.text },
    ["@variable.builtin"] = { fg = c.red },
    ["@operator"] = { fg = c.sky },
    ["@punctuation"] = { fg = c.overlay2 },
    ["@punctuation.bracket"] = { fg = c.sky },
    ["@comment"] = { fg = c.blue, italic = true },
    ["@tag"] = { fg = c.peach },
    ["@tag.attribute"] = { fg = c.yellow },
    ["@property"] = { fg = c.teal },
    ["@parameter"] = { fg = c.rosewater, italic = true },
    ["@field"] = { fg = c.teal },
    ["@namespace"] = { fg = c.yellow },
    ["@include"] = { fg = c.teal },
    ["@conditional"] = { fg = c.mauve, bold = true },
    ["@repeat"] = { fg = c.mauve, bold = true },
    ["@exception"] = { fg = c.red, bold = true },

    -- floating windows
    NormalFloat = { bg = c.float_bg, fg = c.text },
    FloatBorder = { bg = c.float_bg, fg = c.subtext1 },

    -- popup menu
    Pmenu = { bg = c.base, fg = c.text },
    PmenuSel = { bg = c.surface0, fg = c.text },

    -- line numbers
    LineNr = { fg = c.overlay0 },
    CursorLineNr = { fg = c.text, bold = true },

    -- nvim-tree (transparency support)
    NvimTreeNormal = { bg = "NONE", fg = c.text },
    NvimTreeFolderIcon = { fg = c.blue },
    NvimTreeFolderArrowClosed = { fg = c.subtext1 },
    NvimTreeFolderArrowOpen = { fg = c.subtext1 },
    NvimTreeIndentMarker = { fg = c.overlay0 },
    NvimTreeWinSeparator = { fg = c.cursor_line, bg = "NONE" },
    WinSeparator = { fg = c.subtext1, bg = "NONE" },
  }

  return override, add
end

-- Apply all highlight overrides (called after theme load / on every ColorScheme).
M.apply = function()
  local override, add = build()
  for group, settings in pairs(override) do
    vim.api.nvim_set_hl(0, group, settings)
  end
  for group, settings in pairs(add) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

return M
