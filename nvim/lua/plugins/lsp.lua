return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- 关闭 TypeScript 自动推导类型的内联提示
      inlay_hints = {
        enabled = false,
      },
    },
  },
}
