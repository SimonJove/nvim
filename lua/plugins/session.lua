return {
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      git_use_branch_name = false,        -- formerly auto_session_use_git_branch
      auto_restore_last_session = false,  -- formerly auto_session_enable_last_session
      -- don't eager-load the telescope session picker at startup; it pulls telescope+plenary
      -- into the boot path and defeats telescope's own cmd/keys lazy-loading (:Telescope session-lens still works on demand)
      session_lens = { load_on_setup = false },
    },
  },
}
