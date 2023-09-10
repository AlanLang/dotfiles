return {
  "kylechui/nvim-surround",
  lazy = true,
  keys = { "cs", "ds", "ys" },
  config = function()
    require("nvim-surround").setup({})
  end,
}
