return {
  "roobert/search-replace.nvim",
  lazy = true,
  cmd = {
    "SearchReplaceSingleBufferVisualSelection",
    "SearchReplaceSingleBufferOpen",
    "SearchReplaceWithinVisualSelection",
    "SearchReplaceWithinVisualSelectionCWord",
    "SearchReplaceSingleBufferSelections",
    "SearchReplaceSingleBufferCWord",
    "SearchReplaceSingleBufferCWORD",
    "SearchReplaceSingleBufferCExpr",
    "SearchReplaceSingleBufferCFile",
    "SearchReplaceMultiBufferSelections",
    "SearchReplaceMultiBufferOpen",
    "SearchReplaceMultiBufferCWord",
    "SearchReplaceMultiBufferCWORD",
    "SearchReplaceMultiBufferCExpr",
    "SearchReplaceMultiBufferCFile",
  },
  config = function()
    require("search-replace").setup({
      default_replace_single_buffer_options = "gcI",
      default_replace_multi_buffer_options = "egcI",
    })
  end,
}
