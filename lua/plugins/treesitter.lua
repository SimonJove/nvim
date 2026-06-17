return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- main branch: the ground-up rewrite required by Neovim 0.12. the master branch only supports
    -- 0.10/0.11 and crashes on 0.12 (its query-directive handlers hit the changed treesitter API:
    -- "attempt to call method 'range' (a nil value)"). main is a different, much smaller plugin:
    -- no configs.setup/ensure_installed and no highlight/indent modules — you install the parsers
    -- and turn on features yourself (highlighting/indent/folds are provided by Neovim core).
    branch = "main",
    lazy = false, -- main branch explicitly does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup() -- defaults are fine (only install_dir is configurable)

      -- parsers to keep installed (replaces master's `ensure_installed`). markdown_inline has no
      -- filetype of its own — it is the injected parser for fenced code blocks and is needed by
      -- render-markdown.nvim. :TSUpdate (the build step) keeps these pinned to the tested versions.
      -- note: `jsonc` is not its own parser on main — the jsonc filetype maps to the `json`
      -- parser (vim.treesitter.language.get_lang), so json alone covers .jsonc highlighting.
      local ensure = {
        "lua", "vim", "vimdoc", "bash", "json", "yaml", "toml",
        "markdown", "markdown_inline",
        "javascript", "typescript", "tsx", "html", "css", "scss", "vue",
        "ruby", "python",
      }
      ts.install(ensure) -- async; a no-op for parsers that are already installed

      -- main enables nothing automatically. start highlighting + (experimental) indentation per
      -- buffer — this replaces master's `highlight.enable` / `indent.enable`. the else-branch is the
      -- `auto_install` equivalent: pull a parser the first time a not-yet-installed filetype opens.
      local attempted = {} -- guard so a failed build is not retried every FileType this session

      local function attach(buf)
        if not vim.api.nvim_buf_is_valid(buf) then return end
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        if pcall(vim.treesitter.start, buf, lang) then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          return true
        end
        return false, lang
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        callback = function(ev)
          local started, lang = attach(ev.buf)
          if started or not lang or attempted[lang] then return end
          if vim.tbl_contains(ts.get_available(), lang) then
            attempted[lang] = true
            ts.install({ lang }):await(vim.schedule_wrap(function()
              attach(ev.buf)
            end))
          end
        end,
      })
    end,
  },
}
