local M = {}

function M.setup()
  require("config.autocmds.bigfile").setup()
  require("config.autocmds.goimpl").setup()
  require("config.autocmds.image").setup()
  require("config.autocmds.indent").setup()
  require("config.autocmds.kitty").setup()
  require("config.autocmds.pairs").setup()
end

return M
