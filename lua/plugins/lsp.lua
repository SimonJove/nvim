return {
  -- mason: LSP / tool installer
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = { ui = { border = "rounded" } },
  },

  -- mason-lspconfig: bridges mason and lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local servers = { "lua_ls", "ts_ls", "cssls", "html", "jsonls", "pyright", "solargraph" }

      -- completion capabilities (used by cmp)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- bind keymaps on LSP attach (g for jumps + <leader>c for code actions)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(ev)
          local function m(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
          end
          m("gd", vim.lsp.buf.definition, "Go to definition")
          m("gD", vim.lsp.buf.declaration, "Go to declaration")
          m("gr", vim.lsp.buf.references, "Find references")
          m("gI", vim.lsp.buf.implementation, "Go to implementation")
          m("gy", vim.lsp.buf.type_definition, "Type definition")
          m("K", vim.lsp.buf.hover, "Hover docs")
          m("<leader>cr", vim.lsp.buf.rename, "Rename")
          m("<leader>ca", vim.lsp.buf.code_action, "code action")
        end,
      })

      -- mason is set up via its own spec opts (incl. ui.border); don't call again here to avoid overriding
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        -- automatic_installation was removed in mason-lspconfig v2; automatic_enable=false avoids duplicating the manual enable below
        automatic_enable = false,
      })

      -- nvim 0.11 native: set default capabilities for all, then enable each server we specified
      vim.lsp.config("*", { capabilities = capabilities })
      vim.lsp.config("lua_ls", {
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end
    end,
  },
}
