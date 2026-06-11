return {
  "folke/snacks.nvim",
  opts = { 
    picker = {
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
          auto_close = true,
          jump = { close = true },
        }
      }
    }
  },
}