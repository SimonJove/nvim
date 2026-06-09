-- Single source of truth for colors — dark only (catppuccin mocha).
--
-- Resolves colors from catppuccin's mocha palette and layers a few custom UI shades on
-- top, so config.highlights and the plugin UIs (lualine) share one color definition.
-- The light/latte path and <leader>ut toggle were removed: this config is mocha-only.
--
-- catppuccin palette keys: base mantle crust  surface0/1/2  overlay0/1/2
--   subtext0/1 text  rosewater flamingo pink mauve red maroon peach yellow
--   green teal sky sapphire blue lavender
local M = {}

-- Custom (non-catppuccin) UI shades.
--   cursor_line : subtle line background (CursorLine / Folded / tree separator)
--   float_bg    : darker-than-base floating window background
--   terminal_bg : terminal background
M.custom = { cursor_line = "#1a2332", float_bg = "#0f1419", terminal_bg = "#141b26" }

-- Full color set: catppuccin mocha palette + custom UI shades. Returns a fresh table
-- (does not mutate catppuccin's cached palette).
function M.get()
  local ok, cp = pcall(function()
    return require("catppuccin.palettes").get_palette("mocha")
  end)
  if not ok or type(cp) ~= "table" then
    cp = {}
  end
  return vim.tbl_extend("force", {}, cp, M.custom)
end

return M
