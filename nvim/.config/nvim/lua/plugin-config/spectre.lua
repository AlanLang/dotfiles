return {
  "windwp/nvim-spectre",
  lazy = true,
  cmd = { "Spectre" },
  config = function()
    require("spectre").setup()
  end,
}
