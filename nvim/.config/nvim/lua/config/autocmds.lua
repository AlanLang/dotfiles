-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 自动切换输入法：离开插入模式时切换到英文，进入插入模式时恢复之前的输入法
local ime_autogroup = vim.api.nvim_create_augroup("ImeAutoGroup", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
  group = ime_autogroup,
  callback = function()
    vim.system({ "macism" }, { text = true }, function(out)
      PREVIOUS_IM_CODE_MAC = string.gsub(out.stdout, "\n", "")
    end)
    vim.cmd(":silent :!macism com.apple.keylayout.ABC")
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = ime_autogroup,
  callback = function()
    if PREVIOUS_IM_CODE_MAC then
      vim.cmd(":silent :!macism " .. PREVIOUS_IM_CODE_MAC)
    end
    PREVIOUS_IM_CODE_MAC = nil
  end,
})
