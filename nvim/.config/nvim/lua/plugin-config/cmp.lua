local bind_keys = function(cmp)
  return {
    -- 出现补全
    ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- 取消
    ["<A-,>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- 上一个
    ["<up>"] = cmp.mapping.select_prev_item(),
    -- 下一个
    ["<down>"] = cmp.mapping.select_next_item(),
    -- 确认
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    -- 如果窗口内容太多，可以滚动
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  }
end

local cmp_config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
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
    mapping = bind_keys(cmp),
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