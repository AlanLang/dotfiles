-- 列表操作快捷键
local telescope_config = function()
  local telescope = require("telescope")
  telescope.setup {
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
        i = {
          ["<Tab>"] = "file_vsplit",
        }
      }
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    }
  }

  telescope.load_extension("command_center")
end

return {
  "nvim-telescope/telescope.nvim",
  config = telescope_config,
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" }
}
