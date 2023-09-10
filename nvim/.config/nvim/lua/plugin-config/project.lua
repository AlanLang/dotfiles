return {
  "ahmedkhalf/project.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      detection_methods = { "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln" },
    })
    local status, telescope = pcall(require, "telescope")
    if not status then
      vim.notify("没有找到 telescope")
      return
    end
    pcall(telescope.load_extension, "projects")
  end,
}
