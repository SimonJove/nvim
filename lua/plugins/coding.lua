return {
  -- formatting (manual trigger only via <leader>cf)
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = { "n", "v" },
        desc = "Format",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        ruby = { "rubocop" },
        python = { "ruff_format" },
      },
      -- format-on-save disabled (left to the user's choice)
    },
  },

  -- auto-install formatting tools (manual: run :MasonToolsInstall once after a fresh clone).
  -- Was event="VeryLazy" + run_on_start=true, but under VeryLazy the VimEnter run_on_start
  -- hook never fires (VimEnter already passed), so auto-install was silently dead AND mason
  -- got pulled into every startup for nothing. cmd-only keeps mason out of the boot path.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsUpdateSync", "MasonToolsClean" },
    opts = {
      ensure_installed = { "stylua", "prettier", "ruff" },
      run_on_start = false,
    },
  },

  -- symbol outline
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Symbol outline" },
    },
    config = function()
      require("outline").setup({
        guides = {
          enabled = false,
        },
        outline_window = {
          position = 'right',
          width = 25,
          relative_width = true,
          auto_close = false,
          auto_jump = false,
          jump_highlight_duration = 300,
          center_on_jump = true,
          show_numbers = false,
          show_relative_numbers = false,
          wrap = false,
          show_cursorline = true,
          winhl = 'Normal:Normal,NormalNC:Normal,WinSeparator:WinSeparator',
        },
        outline_items = {
          show_symbol_details = true,
          show_symbol_lineno = false,
          highlight_hovered_item = true,
          auto_set_cursor = true,
          auto_unfold_hover = true,
        },
        symbol_folding = {
          autofold_depth = 1,
          auto_unfold = {
            hovered = true,
            only = true,
          },
          markers = { '', '' },
        },
        symbols = {
          icons = {
            File = { icon = "󰈔", hl = "@text.uri" },
            Module = { icon = "󰏗", hl = "@namespace" },
            Namespace = { icon = "󰦮", hl = "@namespace" },
            Package = { icon = "󰆦", hl = "@namespace" },
            Class = { icon = "󰌗", hl = "@type" },
            Method = { icon = "󰊕", hl = "@method" },
            Property = { icon = "󰜢", hl = "@method" },
            Field = { icon = "󰜢", hl = "@field" },
            Constructor = { icon = "󰆧", hl = "@constructor" },
            Enum = { icon = "󰕘", hl = "@type" },
            Interface = { icon = "󰜰", hl = "@type" },
            Function = { icon = "󰡱", hl = "@function" },
            Variable = { icon = "󰫧", hl = "@constant" },
            Constant = { icon = "󰏿", hl = "@constant" },
            String = { icon = "󰀬", hl = "@string" },
            Number = { icon = "󰎠", hl = "@number" },
            Boolean = { icon = "󰨚", hl = "@boolean" },
            Array = { icon = "󰅪", hl = "@constant" },
            Object = { icon = "󰅩", hl = "@type" },
            Key = { icon = "󰌋", hl = "@type" },
            Null = { icon = "󰟢", hl = "@type" },
            EnumMember = { icon = "󰕘", hl = "@field" },
            Struct = { icon = "󰌗", hl = "@type" },
            Event = { icon = "󰉁", hl = "@type" },
            Operator = { icon = "󰆕", hl = "@operator" },
            TypeParameter = { icon = "󰊄", hl = "@parameter" },
            Component = { icon = "󰡀", hl = "@function" },
            Fragment = { icon = "󰅴", hl = "@constant" },
          },
        },
        keymaps = {
          close = {"<Esc>", "q"},
          goto_location = "<Cr>",
          peek_location = "o",
          goto_and_close = "<S-Cr>",
          restore_location = "<C-g>",
          hover_symbol = "<C-space>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_toggle = "<Tab>",
          fold_toggle_all = "<S-Tab>",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
        },
        providers = {
          priority = { 'lsp', 'coc', 'markdown', 'norg' },
          lsp = {
            blacklist_clients = {},
          },
        },
      })
    end,
  },

  -- Emmet (frontend HTML/CSS expansion)
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "scss", "sass", "vue", "javascriptreact", "typescriptreact", "erb", "hbs" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-Z>"
      vim.g.user_emmet_mode = "i"
      vim.g.user_emmet_install_global = 0
      vim.g.user_emmet_install_command = 0
      vim.g.user_emmet_complete_tag = 1
    end,
  },

  -- Rails support
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
  },
}
