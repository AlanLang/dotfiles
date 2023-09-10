local noremap = { noremap = true }
local silent_noremap = { noremap = true, silent = true }

local command_center_config = function()
  local command_center = require("command_center")
  command_center.add({
    {
      desc = "find files",
      cmd = ":Telescope find_files<CR>",
      keys = { "n", "<C-p>", noremap },
    },
    {
      desc = "format filed",
      cmd = "<cmd>lua vim.lsp.buf.format({ async = true })<CR>"
    },
    {
      desc = "commands",
      cmd = ":Telescope commands<CR>"
    },
    {
      desc = "jump list",
      cmd = ":Telescope jumplist<CR>"
    },
    {
      desc = "keymaps",
      cmd = ":Telescope keymaps<CR>"
    },
    {
      desc = "search string",
      cmd = "<cmd>lua require('spectre').open()<cr>"
    },
    {
      desc = "command history",
      cmd = ":Telescope command_history<CR>"
    },
    {
      desc = "trouble toggle",
      cmd = ":TroubleToggle<CR>"
    },
    {
      desc = "marks list all",
      cmd = "<cmd>MarksListAll<CR>"
    },
    {
      desc = "Run Jest on current file",
      cmd = ':lua require"jester".run_file()<CR>'
    },
    {
      desc = "Run Jest on current test",
      cmd = ':lua require"jester".run()<CR>'
    },
    {
      desc = "Debug Jest on current test",
      cmd = ':lua require"jester".debug()<CR>'
    },
    {
      desc = "Run last Jest test",
      cmd = ':lua require"jester".run_last()<CR>'
    },
    {
      desc = "exit vim",
      cmd = ":qa<CR>"
    },
    {
      desc = "Search replace string buffer open",
      cmd = ":SearchReplaceSingleBufferOpen<CR>"
    },
    {
      desc = "Search replace multiple buffer open",
      cmd = ":SearchReplaceMultiBufferOpen<CR>"
    },
    {
      desc = "ask ai",
      cmd = ":NeoAI<CR>"
    },
    {
      desc = "diff view open",
      cmd = ":DiffviewOpen<CR>"
    },
    {
      desc = "diff view close",
      cmd = ":DiffviewClose<CR>"
    }
  })
end

return {
  "FeiyouG/command_center.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = command_center_config,
  lazy = true,
  cmd = "Telescope command_center",
}
