local M = {}

function M.setup()
  require("config.settings.global").setup()
  require("config.settings.opts").setup()
  require("config.langs.diagnostic").setup()
  require("config.langs.fold").setup()
  require("config.ui.statusline").setup()
  require("config.ui.notify").setup()
end

return M
