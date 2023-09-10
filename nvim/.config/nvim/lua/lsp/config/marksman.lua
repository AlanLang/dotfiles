return {
  on_setup = function(server)
    server:setup({
      settings = {
        marksman = {
          validate = true,
        },
      },
      flags = {
        debounce_text_changes = 150,
      }
    })
  end,
}
