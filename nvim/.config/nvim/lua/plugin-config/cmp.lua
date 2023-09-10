local cmp_config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local format = {
    format = require("lspkind").cmp_format({
      mode = 'symbol',
      --mode = 'symbol', -- show only symbol annotations

      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        -- Source 显示提示来源
        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
        return vim_item
      end
    })
  }
  cmp.setup({
    completion = {
      -- 自动选中第一条
      completeopt = "menu,menuone,noinsert",
    },
    -- 指定 snippet 引擎
    snippet = {
      expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      cmp_tabnine = 1,
      buffer = 1,
      path = 1,
    },
    -- 补全源
    sources = cmp.config.sources {
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip",  priority = 750 },
      { name = "buffer",   priority = 500 },
      { name = "path",     priority = 250 },
    },

    -- 快捷键设置
    mapping = require("keybindings").cmp(cmp),
    -- 使用lspkind-nvim显示类型图标
    formatting = format
  })

  -- / 查找模式使用 buffer 源
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- : 命令行模式中使用 path 和 cmdline 源.
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

local luasnip_config = function(_, opts)
  if opts then require("luasnip").config.setup(opts) end
  vim.tbl_map(function(type) require("luasnip.loaders.from_" .. type).lazy_load() end, { "vscode", "snipmate", "lua" })
end


return {
  {
    "L3MON4D3/LuaSnip",
    build = vim.fn.has "win32" == 0
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
        or nil,
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = { store_selection_keys = "<C-x>" },
    config = luasnip_config,
  },
  {
    "hrsh7th/nvim-cmp",
    config = cmp_config,
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
  }
}
