return {
  "0x00-ketsu/maximizer.nvim",
  lazy = true,
  keys = {
    { "<leader>n", '<cmd>lua require("maximizer").toggle()<CR>' },
  },
  config = function()
    require("maximizer").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}
