return {
  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Quick find files" },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "Find all (incl. hidden)" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffer list" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
      },
    },
  },

  -- which-key: keymap hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "find" },
        { "<leader>c", group = "code" },
        { "<leader>b", group = "buffer" },
        { "<leader>g", group = "git" },
        { "<leader>u", group = "toggle" },
        { "]", group = "next" },
        { "[", group = "prev" },
      },
    },
  },

  -- file tree
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "File tree" },
    },
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      filters = { dotfiles = false },
      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        width = 30,
        adaptive_size = true,
        centralize_selection = true,
        preserve_window_proportions = true,
      },

      actions = {
        open_file = {
          resize_window = true,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = { ".git", "target", "build" },
        },
      },

      -- Custom key mappings
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Custom mappings
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Override h and l mappings (no need to delete first)
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      end,
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = {
          enable = true,
          inline_arrows = true,
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            modified = "●",
            folder = {
              arrow_closed = "▸",  -- thin arrow
              arrow_open = "▾",    -- thin arrow
              default = "",      -- clean folder icon
              open = "",        -- clean open folder icon
              empty = "",       -- clean empty folder icon
              empty_open = "",  -- clean empty open folder icon
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "•",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "✗",
              ignored = "◌"
            },
          },
        },
      },
    },
  },

  -- quick jump
  {
    "folke/flash.nvim",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    },
  },

  -- yazi file manager
  {
    "mikavilpas/yazi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Yazi",
    keys = {
      { "<leader>-", "<cmd>Yazi<CR>", desc = "Yazi file manager" },
    },
    opts = {
      open_for_directories = false,
      floating_window_scaling_factor = 0.9,
      yazi_floating_window_winblend = 0,
    },
  },

  -- undo history tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>z", "<cmd>UndotreeToggle<CR>", desc = "Undotree" },
    },
  },

  -- comments (pairs with nvim 0.10+ built-in gc; Comment.nvim as enhancement, unified gc/gcc keymaps)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    -- basic=false keeps Neovim 0.10+ built-in gc/gcc (treesitter-aware); extra=true only adds gco/gcO/gcA
    opts = { mappings = { basic = false, extra = true } },
  },

  -- auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
