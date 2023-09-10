return {
  "numToStr/Comment.nvim",
  lazy = true,
  keys = { "gcc", "gbc", { "gc", mode = { "v" } }, { "gb", mode = { "v" } } },
  config = function()
    require("Comment").setup()
  end,
}
