-- Global keymaps (plugin-independent ones; plugin-specific keys live in the keys field of each plugins/*.lua)
local map = vim.keymap.set

-- exit insert mode with jk (replaces better-escape.nvim)
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- save file (n/i/x; <cmd> keeps the current mode, unlike NvChad's which leaves insert)
map({ "n", "i", "x" }, "<C-s>", "<cmd>write<CR>", { desc = "Save file" })

-- clear search highlight by pressing Esc in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- toggle line numbers / wrap
map("n", "<leader>un", "<cmd>set nu!<CR>", { desc = "Toggle line numbers" })
map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })

-- buffer close (migrated from old smart_close_buffer / close_all_buffers, keeps the fixed no-empty-buffer logic)
map("n", "<leader>bd", function()
  pcall(vim.cmd, "OutlineClose")
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].modified then
    vim.cmd("confirm bdelete")
  else
    vim.cmd("bdelete")
  end
end, { desc = "Smart close buffer" })

map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if b ~= current and vim.bo[b].buflisted then
      if vim.bo[b].modified then
        vim.cmd("confirm bdelete " .. b)
      else
        vim.cmd("bdelete " .. b)
      end
    end
  end
end, { desc = "Close other buffers" })

-- move between windows
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- keep selection after indenting in visual mode
map("x", "<", "<gv", { desc = "Indent and keep selection" })
map("x", ">", ">gv", { desc = "Indent and keep selection" })

-- diagnostic navigation (mainstream ] / [ convention)
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostic float" })
map("n", "<leader>cl", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
