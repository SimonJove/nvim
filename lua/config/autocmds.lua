-- Autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- transparent background: force Normal background transparent after theme loads (works with catppuccin transparent_background, without breaking light theme foreground)
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  pattern = "*",
  callback = function()
    -- reapply custom highlight overrides after theme load/switch
    require("config.highlights").apply()
    -- force Normal background transparent (works with catppuccin transparent_background, without breaking light theme foreground)
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})
