return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = true,
  cmd = { "TroubleToggle", "Trouble", "TroubleRefresh" },
  config = function()
    require("trouble").setup({
      auto_open = false,
      auto_close = true,
      auto_preview = true,
      auto_fold = false,
      signs = {
        error = " ",
        warning = " ",
        hint = " ",
        information = " ",
        other = "﫠",
      },
      use_lsp_diagnostic_signs = true,
    })
  end,
}
