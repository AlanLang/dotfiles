return {
  "karb94/neoscroll.nvim",
  lazy = true,
  -- event = "WinScrolled",
  keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
  config = function()
    require("neoscroll").setup({
      -- All these keys will be mapped to their corresponding default scrolling animation
      -- mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true,
      stop_eof = true,
      use_local_scrolloff = false,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      -- quadratic, cubic, quartic, quintic, circular, sine
      easing_function = "cubic",
      pre_hook = nil,
      post_hook = nil,
    })

    local t = {}
    t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "50", [['cubic']] } }
    t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "50", [['cubic']] } }
    t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "50", [['cubic']] } }
    t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "50", [['cubic']] } }
    t["<C-y>"] = { "scroll", { "-0.10", "false", "50", [['cubic']] } }
    t["<C-e>"] = { "scroll", { "0.10", "false", "50", [['cubic']] } }
    t["zt"] = { "zt", { "100", [['cubic']] } }
    t["zz"] = { "zz", { "100", [['cubic']] } }
    t["zb"] = { "zb", { "100", [['cubic']] } }

    require("neoscroll.config").set_mappings(t)
  end,
}
