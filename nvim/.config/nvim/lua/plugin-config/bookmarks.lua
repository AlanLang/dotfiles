return {
  'tomasky/bookmarks.nvim',
  after = "telescope.nvim",
  event = "VimEnter",
  dependencies = { "folke/which-key.nvim" },
  config = function()
    require('bookmarks').setup({
      on_attach = function(bufnr)
        local wk = require("which-key")
        local bm = require "bookmarks"
        wk.add({
          {
            mode = "n",
            buffer = bufnr,
            { "<leader>m", group = "bookmarks", icon = { icon = " ", color = "blue" } },
            { "<leader>mm", bm.bookmark_toggle, desc = "Toggle bookmark", icon = { icon = "󰸕 ", color = "blue" } },
            { "<leader>mi", bm.bookmark_ann, desc = "Add or edit mark annotation", icon = { icon = "󰃅 ", color = "blue" } },
            { "<leader>mc", bm.bookmark_clean, desc = "Clean all marks in local buffer", icon = { icon = "󰧌 ", color = "blue" } },
            { "<leader>mn", bm.bookmark_next, desc = "Jump to next mark", icon = { icon = "󰮰 ", color = "blue" } },
            { "<leader>mp", bm.bookmark_prev, desc = "Jump to previous mark", icon = { icon = "󰮲 ", color = "blue" } },
            { "<leader>ml", ":Telescope bookmarks list<CR>", desc = "Show marked file list", icon = { icon = " ", color = "blue" } },
            { "<leader>mx", bm.bookmark_clear_all, desc = "Remove all bookmarks", icon = { icon = "󰃆 ", color = "blue" } },
          },
        })
      end
    })
  end
}
