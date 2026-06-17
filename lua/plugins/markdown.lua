return {
  -- in-editor markdown rendering: headings, code blocks, lists, tables, quotes, callouts, checkboxes.
  -- renders inline in the buffer (NOT a browser preview); the cursor's line falls back to raw
  -- source so it stays editable (anti-conceal). most-starred of the in-editor renderers.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- markdown parser already ensured in treesitter.lua; web-devicons already used across ui.lua
    -- (here it supplies code-block language icons)
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    keys = {
      -- fits the existing <leader>u "toggle" group (cf. <leader>uH for inlay hints)
      { "<leader>um", "<cmd>RenderMarkdown toggle<CR>", ft = "markdown", desc = "Toggle markdown render" },
    },
    -- defaults look good out of the box and pick up the catppuccin treesitter highlights
    opts = {},
  },
}
