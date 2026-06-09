return {
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      git_use_branch_name = false,        -- formerly auto_session_use_git_branch
      auto_restore_last_session = false,  -- formerly auto_session_enable_last_session
    },
  },
}
