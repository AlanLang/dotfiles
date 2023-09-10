local mason_lsp_config = function()
  require("mason-lspconfig").setup({
    -- 确保安装，根据需要填写
    ensure_installed = {
      "tsserver",
      "tailwindcss",
      "bashls",
      "cssls",
      "dockerls",
      "emmet_ls",
      "html",
      "jsonls",
      "pyright",
      "rust_analyzer",
      "taplo",
      "yamlls",
      "lua_ls",
      "eslint",
      "marksman"
    },
  })
end

return {
  "williamboman/mason-lspconfig.nvim",
  config = mason_lsp_config,
  lazy = true,
  event = "VeryLazy"
}
