local M = {}

function M.setup()
  local ok, remote_nvim = pcall(require, "remote-nvim")
  if not ok then
    return
  end

  remote_nvim.setup({})
end

return M
