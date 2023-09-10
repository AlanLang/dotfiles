return {
  "jay-babu/mason-null-ls.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",

  },
  config = function()
    local null_ls = require("null-ls");
    require("mason-null-ls").setup({
      ensure_installed = { "cspell" }
    })
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.cspell.with({
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
        }),
        null_ls.builtins.code_actions.cspell
      }
    })
  end,
}
