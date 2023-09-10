local nvim_lsp_config = function()
  require("lsp.ui")
  local lspconfig = require("lspconfig")
  local servers = {
    lua_ls = require("lsp.config.lua"),
    tsserver = require("lsp.config.ts"),
    eslint = require("lsp.config.eslint"),
    cssls = require("lsp.config.css"),
    emmet_ls = require("lsp.config.emmet_ls"),
    tailwindcss = require("lsp.config.tailwindcss"),
    marksman = require("lsp.config.marksman"),
    html = require("lsp.config.html"),
    rust_analyzer = require("lsp.config.rust"),
  }
  for name, config in pairs(servers) do
    if config ~= nil and type(config) == "table" then
      -- 自定义初始化配置文件必须实现on_setup 方法
      config.on_setup(lspconfig[name])
    else
      -- 使用默认参数
      lspconfig[name].setup({})
    end
  end
end

return {
  "neovim/nvim-lspconfig",
  config = nvim_lsp_config,
  event = "VeryLazy",
  lazy = true,
}
