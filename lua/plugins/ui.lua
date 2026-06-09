return {
  -- theme: catppuccin mocha, transparent background
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- theme must load first
    opts = {
      flavour = "mocha", -- dark only; the light/latte toggle was removed
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = true,
        which_key = true,
        mason = true,
        flash = true,
        bufferline = true, -- let catppuccin theme the tabline to match the editor
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      -- setting the colorscheme triggers the ColorScheme callback in autocmds.lua, auto-applying highlights + transparent background
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- file icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- indent guides v3
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      -- only filetypes this config actually uses (NvimTree was missing; the rest were dead)
      exclude = {
        filetypes = { "help", "lazy", "mason", "NvimTree" },
      },
    },
  },

  -- VSCode-style buffer tabs
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
      { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    },
    opts = {
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        themable = true,
        numbers = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,

        -- Tab styling with smaller icons
        indicator = {
          icon = "▏", -- thinner indicator line
          style = "icon",
        },
        buffer_close_icon = "×",
        modified_icon = "•",
        close_icon = "×",
        left_trunc_marker = "‹",
        right_trunc_marker = "›",

        -- Layout
        max_name_length = 30,
        max_prefix_length = 30,
        truncate_names = true,
        tab_size = 21,
        diagnostics = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          }
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,

        -- Separator style
        separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' }
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
        },
        sort_by = 'insert_after_current',
      },
    },
  },

  -- statusline lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- palette, single-sourced from config.palette
      local p = require("config.palette").get()

      -- Custom theme matching terminal background
      local custom_theme = {
        normal = {
          a = { bg = p.blue, fg = p.base, gui = "bold" },
          b = { bg = p.surface0, fg = p.text },
          c = { bg = p.base, fg = p.subtext1 },
        },
        insert = {
          a = { bg = p.green, fg = p.base, gui = "bold" },
          b = { bg = p.surface0, fg = p.text },
          c = { bg = p.base, fg = p.subtext1 },
        },
        visual = {
          a = { bg = p.yellow, fg = p.base, gui = "bold" },
          b = { bg = p.surface0, fg = p.text },
          c = { bg = p.base, fg = p.subtext1 },
        },
        replace = {
          a = { bg = p.red, fg = p.base, gui = "bold" },
          b = { bg = p.surface0, fg = p.text },
          c = { bg = p.base, fg = p.subtext1 },
        },
        command = {
          a = { bg = p.mauve, fg = p.base, gui = "bold" },
          b = { bg = p.surface0, fg = p.text },
          c = { bg = p.base, fg = p.subtext1 },
        },
        inactive = {
          a = { bg = p.surface0, fg = p.overlay0 },
          b = { bg = p.base, fg = p.overlay0 },
          c = { bg = p.base, fg = p.overlay0 },
        },
      }

      require("lualine").setup({
        options = {
          theme = custom_theme,
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = { statusline = { "NvimTree", "alpha" } },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                local mode_map = {
                  NORMAL = "N",
                  INSERT = "I",
                  VISUAL = "V",
                  ["V-LINE"] = "VL",
                  ["V-BLOCK"] = "VB",
                  COMMAND = "C",
                  REPLACE = "R",
                  TERMINAL = "T",
                }
                return mode_map[str] or str:sub(1, 1)
              end,
              separator = { right = "" },
            },
          },
          lualine_b = {
            {
              "branch",
              icon = "",
              color = { fg = p.blue, gui = "bold" },
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
              diff_color = {
                added = { fg = p.green },
                modified = { fg = p.yellow },
                removed = { fg = p.red },
              },
            },
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              newfile_status = true,
              path = 1,
              symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = "[No Name]",
                newfile = " [New]",
              },
              color = { fg = p.text },
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
              diagnostics_color = {
                error = { fg = p.red },
                warn = { fg = p.yellow },
                info = { fg = p.sky },
                hint = { fg = p.teal },
              },
            },
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then
                  return ""
                end
                return " LSP"
              end,
              color = { fg = p.green, gui = "bold" },
            },
            {
              "filetype",
              colored = true,
              icon_only = false,
              color = { fg = p.mauve },
            },
          },
          lualine_y = {
            {
              "encoding",
              fmt = string.upper,
              color = { fg = p.peach },
            },
            {
              "fileformat",
              fmt = string.upper,
              icons_enabled = false,
              color = { fg = p.peach },
            },
          },
          lualine_z = {
            {
              "location",
              separator = { left = "" },
              color = { fg = p.base, bg = p.blue, gui = "bold" },
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              color = { fg = p.overlay0 },
            }
          },
          lualine_x = {
            {
              "location",
              color = { fg = p.overlay0 },
            }
          },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
