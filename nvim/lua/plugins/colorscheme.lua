return {
  -- everforest 主题：https://github.com/neanias/everforest-nvim
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- 确保在其他 start 插件之前加载
    config = function()
      require("everforest").setup({
        background = "medium", -- soft / medium / hard
        transparent_background_level = 2,
        italics = true,
      })
    end,
  },

  -- 让 LazyVim 使用 everforest 作为默认配色
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
