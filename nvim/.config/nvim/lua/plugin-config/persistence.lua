return {
  "folke/persistence.nvim",
  -- Restore last session of current dir
  lazy = true,
  event = "BufReadPre",   -- this will only start session saving when an actual file was opened
  config = function()
    require("persistence").setup({
      dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
      options = { "buffers", "curdir", "tabpages", "winsize" },
      pre_save = nil,
    })
  end,
}
