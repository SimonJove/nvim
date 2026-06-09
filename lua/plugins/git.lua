return {
  -- git change signs + hunk operations
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function m(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
        end
        -- hunk navigation (mainstream ] / [ convention)
        m("]c", function() gs.nav_hunk("next") end, "Next git hunk")
        m("[c", function() gs.nav_hunk("prev") end, "Previous git hunk")
        -- git group actions
        m("<leader>gp", gs.preview_hunk, "Preview hunk")
        m("<leader>gb", function() gs.blame_line({ full = true }) end, "Blame current line")
      end,
    },
  },

  -- lazygit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "lazygit" },
    },
  },

  -- git-related telescope (status / commits)
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "git status" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "git commits" },
    },
  },
}
