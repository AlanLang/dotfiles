local treesitter_config = function()
  require("nvim-treesitter.configs").setup({
    -- 安装 language parser
    -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx" },
    -- 启用代码高亮模块
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    autotag = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
        scope_incremental = "<TAB>",
      },
    }, -- 启用代码缩进模块 (=)
    indent = {
      enable = true,
    },
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  config = treesitter_config,
  lazy = true,
  cmd = {
    "TSBufDisable",
    "TSBufEnable",
    "TSBufToggle",
    "TSDisable",
    "TSEnable",
    "TSToggle",
    "TSInstall",
    "TSInstallInfo",
    "TSInstallSync",
    "TSModuleInfo",
    "TSUninstall",
    "TSUpdate",
    "TSUpdateSync",
  },
}
