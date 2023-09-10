return {
  "max397574/better-escape.nvim",
  lazy = true,
  event = { "InsertEnter" },
  config = function()
    require("better_escape").setup({
      mapping = { "jk", "jl" },
      timeout = 200,
      clear_empty_lines = false,
      keys = "<Esc>",
    })
  end,
}
