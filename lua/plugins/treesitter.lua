return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- pinned to master branch: stable, well-documented, provides configs.setup/ensure_installed/highlight APIs (the main branch API is incompatible)
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc", "bash", "json", "jsonc", "yaml", "toml",
        "markdown", "markdown_inline",
        "javascript", "typescript", "tsx", "html", "css", "scss", "vue",
        "ruby", "python",
      },
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
