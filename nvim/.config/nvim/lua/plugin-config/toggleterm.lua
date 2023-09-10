-- 终端
return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  cmd = "ToggleTerm",
  config = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup({
      direction = 'float',
    })
  end
}
