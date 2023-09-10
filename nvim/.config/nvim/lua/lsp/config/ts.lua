local common = require("lsp.common-config")
local keybindings = require("keybindings")
local opts = {
  flags = common.flags,
  capabilities = common.capabilities,

  -- https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils/blob/main/lua/nvim-lsp-ts-utils/utils.lua
  -- 传入 tsserver 初始化参数
  -- make inlay hints work
  init_options = {
    hostInfo = "neovim",
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },

  on_attach = function(client, bufnr)
    common.disableFormat(client)
    common.keyAttach(bufnr)
    -- no default maps, so you may want to define some here
    keybindings.mapTsLSP(bufnr)
  end,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
