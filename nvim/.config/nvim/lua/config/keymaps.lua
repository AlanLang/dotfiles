-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Marks picker：<C-d> 删除选中的标记
vim.keymap.set("n", "<leader>sm", function()
  Snacks.picker.marks({
    actions = {
      mark_delete = {
        action = function(picker, item)
          Snacks.picker.actions.mark_delete(picker, item)
        end,
      },
    },
    win = {
      input = {
        keys = {
          ["<C-d>"] = { "mark_delete", mode = { "i", "n" } },
        },
      },
    },
  })
end, { desc = "Marks (可 <C-d> 删除)" })

-- 保存所有 buffer
vim.keymap.set("n", "<leader>bs", "<cmd>wa<cr>", { desc = "Save All Buffers" })
vim.keymap.set("n", "<leader>bw", "<cmd>w<cr>", { desc = "Save Buffer" })

-- 复制当前文件路径 + 行号（相对路径）
vim.keymap.set("n", "<leader>yl", function()
  local path = vim.fn.expand("%:.")
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local result = path .. ":" .. line
  vim.fn.setreg("+", result)
  vim.notify("已复制：" .. result)
end, { desc = "Copy: 文件路径 + 行号" })
