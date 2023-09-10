return {
  "booperlv/nvim-gomove",
  layz = true,
  event = "VeryLazy",
  config = function()
    require("gomove").setup({
      map_defaults = false,
      reindent = true,
      undojoin = true,
      move_past_end_col = false,
    })
    local map = vim.api.nvim_set_keymap
    map("x", "<left>", "<Plug>GoVSMLeft", { noremap = true, silent = true })
    map("x", "<down>", "<Plug>GoVSMDown", { noremap = true, silent = true })
    map("x", "<up>", "<Plug>GoVSMUp", { noremap = true, silent = true })
    map("x", "<right>", "<Plug>GoVSMRight", { noremap = true, silent = true })

    map("x", "<C-h>", "<Plug>GoVSDLeft", { noremap = true, silent = true })
    map("x", "<C-j>", "<Plug>GoVSDDown", { noremap = true, silent = true })
    map("x", "<C-k>", "<Plug>GoVSDUp", { noremap = true, silent = true })
    map("x", "<C-l>", "<Plug>GoVSDRight", { noremap = true, silent = true })
  end,
}
