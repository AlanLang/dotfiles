-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 复制当前文件路径 + 行号（相对路径）
vim.keymap.set("n", "<leader>yl", function()
  local path = vim.fn.expand("%:.")
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local result = path .. ":" .. line
  vim.fn.setreg("+", result)
  vim.notify("已复制：" .. result)
end, { desc = "Copy: 文件路径 + 行号" })
