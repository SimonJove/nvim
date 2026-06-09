return {
  -- theme: catppuccin, transparent background, mocha/latte toggle
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- theme must load first
    opts = {
      flavour = "auto", -- follows vim.o.background: dark→mocha, light→latte, makes <leader>ut toggle work
      background = { light = "latte", dark = "mocha" },
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
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
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

      highlights = {
        fill = {
          bg = "#141b26", -- Match terminal background
        },
        background = {
          fg = "#8B949E",
          bg = "#21262D",
        },
        buffer_selected = {
          fg = "#cdd6f4",
          bg = "#1e1e2e", -- Match editor background
          bold = true,
          italic = false,
        },
        buffer_visible = {
          fg = "#C9D1D9",
          bg = "#30363D",
        },
        close_button = {
          fg = "#8B949E",
          bg = "#21262D",
        },
        close_button_visible = {
          fg = "#C9D1D9",
          bg = "#30363D",
        },
        close_button_selected = {
          fg = "#f38ba8",
          bg = "#1e1e2e", -- Match editor background
          bold = true,
        },
        tab_close = {
          fg = "#F85149",
          bg = "#141b26",
        },
        indicator_selected = {
          fg = "#89b4fa",
          bg = "#1e1e2e", -- Match editor background
        },
        modified = {
          fg = "#D29922",
          bg = "#21262D",
        },
        modified_visible = {
          fg = "#F2CC60",
          bg = "#30363D",
        },
        modified_selected = {
          fg = "#a6e3a1",
          bg = "#1e1e2e", -- Match editor background
          bold = true,
        },
        separator = {
          fg = "#141b26",
          bg = "#21262D",
        },
        separator_selected = {
          fg = "#1e1e2e",
          bg = "#1e1e2e", -- Match editor background
        },
        separator_visible = {
          fg = "#141b26",
          bg = "#30363D",
        },
        -- Additional colorful highlights
        duplicate_selected = {
          fg = "#cdd6f4",
          bg = "#1e1e2e", -- Match editor background
          italic = true,
        },
        duplicate_visible = {
          fg = "#C9D1D9",
          bg = "#30363D",
          italic = true,
        },
        duplicate = {
          fg = "#8B949E",
          bg = "#21262D",
          italic = true,
        },
        numbers = {
          fg = "#79C0FF",
          bg = "#21262D",
        },
        numbers_visible = {
          fg = "#79C0FF",
          bg = "#30363D",
        },
        numbers_selected = {
          fg = "#cdd6f4",
          bg = "#1e1e2e", -- Match editor background
          bold = true,
        },
      },
    },
  },

  -- statusline lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Custom theme matching terminal background
      local custom_theme = {
        normal = {
          a = { bg = "#89b4fa", fg = "#1e1e2e", gui = "bold" },
          b = { bg = "#313244", fg = "#cdd6f4" },
          c = { bg = "#1e1e2e", fg = "#bac2de" },
        },
        insert = {
          a = { bg = "#a6e3a1", fg = "#1e1e2e", gui = "bold" },
          b = { bg = "#313244", fg = "#cdd6f4" },
          c = { bg = "#1e1e2e", fg = "#bac2de" },
        },
        visual = {
          a = { bg = "#f9e2af", fg = "#1e1e2e", gui = "bold" },
          b = { bg = "#313244", fg = "#cdd6f4" },
          c = { bg = "#1e1e2e", fg = "#bac2de" },
        },
        replace = {
          a = { bg = "#f38ba8", fg = "#1e1e2e", gui = "bold" },
          b = { bg = "#313244", fg = "#cdd6f4" },
          c = { bg = "#1e1e2e", fg = "#bac2de" },
        },
        command = {
          a = { bg = "#cba6f7", fg = "#1e1e2e", gui = "bold" },
          b = { bg = "#313244", fg = "#cdd6f4" },
          c = { bg = "#1e1e2e", fg = "#bac2de" },
        },
        inactive = {
          a = { bg = "#313244", fg = "#6c7086" },
          b = { bg = "#1e1e2e", fg = "#6c7086" },
          c = { bg = "#1e1e2e", fg = "#6c7086" },
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
              color = { fg = "#89b4fa", gui = "bold" },
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
              diff_color = {
                added = { fg = "#a6e3a1" },
                modified = { fg = "#f9e2af" },
                removed = { fg = "#f38ba8" },
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
              color = { fg = "#cdd6f4" },
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
              diagnostics_color = {
                error = { fg = "#f38ba8" },
                warn = { fg = "#f9e2af" },
                info = { fg = "#89dceb" },
                hint = { fg = "#94e2d5" },
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
              color = { fg = "#a6e3a1", gui = "bold" },
            },
            {
              "filetype",
              colored = true,
              icon_only = false,
              color = { fg = "#cba6f7" },
            },
          },
          lualine_y = {
            {
              "encoding",
              fmt = string.upper,
              color = { fg = "#fab387" },
            },
            {
              "fileformat",
              fmt = string.upper,
              icons_enabled = false,
              color = { fg = "#fab387" },
            },
          },
          lualine_z = {
            {
              "location",
              separator = { left = "" },
              color = { fg = "#1e1e2e", bg = "#89b4fa", gui = "bold" },
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              color = { fg = "#6c7086" },
            }
          },
          lualine_x = {
            {
              "location",
              color = { fg = "#6c7086" },
            }
          },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
