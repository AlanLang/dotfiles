local mason_config = function()
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })
end
return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  config = mason_config,
}
