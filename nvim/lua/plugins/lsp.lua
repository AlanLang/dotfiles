return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- 关闭 TypeScript 自动推导类型的内联提示
      inlay_hints = {
        enabled = false,
      },
      -- ESLint warning 不显示下划线，只对 error 显示
      diagnostics = {
        underline = { severity = vim.diagnostic.severity.ERROR },
        virtual_text = false,
      },
    },
  },
}
