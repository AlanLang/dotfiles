local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  on_setup = function(server)
    server:setup({
      capabilities = capabilities,
    })
  end,
}
