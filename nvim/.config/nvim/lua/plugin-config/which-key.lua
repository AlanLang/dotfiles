return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    preset = "modern",
    defaults = {},
    spec = {
      mode = { "n" },
      { "<leader>q", "<C-w>c", desc = "Close window", icon = { icon = "󰅗 ", color = "blue" } },
      { "<leader>w", ":w<CR>", desc = "Save file", icon = { icon = " ", color = "blue" } },
      { "<leader>d", ":vsp<CR>", desc = "Horizontal split", icon = { icon = " ", color = "blue" } },
      { "<leader>v", ":sp<CR>", desc = "Vertical split", icon = { icon = " ", color = "blue" } },
      { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file tree", icon = { icon = "󰙅 ", color = "blue" } },
      { "<leader>o", ":Telescope lsp_document_symbols<CR>", desc = "Show LSP Symbols", icon = { icon = " ", color = "blue" } },
      { "<leader>p", ":Telescope commander<CR>", desc = "Show Command Center", icon = { icon = "󰘳 ", color = "blue" } },
      { "<leader>f", "viw<cmd>lua require('spectre').open_file_search()<CR>", desc = "Search in file", icon = { icon = "󰱼 ", color = "blue" } },
      { "<leader>F", "<cmd>lua require('spectre').open()<cr>", desc = "Search in project", icon = { icon = "󰨭 ", color = "blue" } },
      { "<leader>g", ":Telescope find_files<CR>", desc = "Search files", icon = { icon = "󰥨 ", color = "blue" } },
      { "<leader>G", ":Telescope find_files hidden=true<CR>", desc = "Search files hidden", icon = { icon = "󰥗 ", color = "blue" } },
      { "<leader>a", ":Telescope buffers<CR>", desc = "Show files history", icon = { icon = "󱋡 ", color = "blue" } },

      { "<leader>j", group = "Jump", icon = { icon = " ", color = "blue" } },
      { "<leader>jh", "<C-w>h", desc = "Jump to left window", mode = "n" },
      { "<leader>jj", "<C-w>j", desc = "Jump to down window", mode = "n" },
      { "<leader>jk", "<C-w>k", desc = "Jump to up window", mode = "n" },
      { "<leader>jl", "<C-w>l", desc = "Jump to right window", mode = "n" },
      { "<leader>jb", "<C-o>", desc = "Jump back", mode = "n", icon = { icon = "󰮲 ", color = "blue" } },
      { "<leader>jf", "<C-i>", desc = "Jump forward", mode = "n", icon = { icon = "󰮰 ", color = "blue" } },

      { "<leader>l", group = "List", icon = { icon = " ", color = "blue" } },
      { "<leader>lg", ":Telescope live_grep<CR>", desc = "Search in project", icon = { icon = " ", color = "blue" } },
      { "<leader>lq", ":Telescope quickfix<CR>", desc = "Show Quickfix", icon = { icon = "󰁨 ", color = "blue" } },
      { "<leader>lj", ":Telescope jumplist<CR>", desc = "Show Jump List", icon = { icon = "󱋿 ", color = "blue" } },
      { "<leader>lh", ":Telescope help_tags<CR>", desc = "Show Help Tags", icon = { icon = "󰞋 ", color = "blue" } },

      { "<leader>x", group = "Close", icon = { icon = "󰅗 ", color = "blue" } },
      { "<leader>xo", ":only<CR>", desc = "Close other windows", icon = { icon = "󰅗 ", color = "blue" } },

      { "<leader>n", '<cmd>lua require("maximizer").toggle()<CR>', desc = "Toggle maximize", icon = { icon = " ", color = "blue" } },
    },
  },
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}