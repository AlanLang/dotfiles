-- 自动补全括号
return {
  "windwp/nvim-autopairs",
  lazy = true,
  event = { "InsertEnter" },
  config = function()
    require("nvim-autopairs").setup({})
  end,
}
