return {
  "David-Kunz/jester",
  cmd = "Telescope command_center",
  lazy = true,
  config = function()
    require("jester").setup({
      path_to_jest_run = './node_modules/.bin/jest',
      dap = {
        console = "externalTerminal"
      }
    })
  end
}
