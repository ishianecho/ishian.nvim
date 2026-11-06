local M = {}

function M.setup()
  local ok, claudecode = pcall(require, "claudecode")
  if not ok then
    return
  end

  claudecode.setup({
    terminal = {
      provider = "native",
      split_width_percentage = 0.5,
    },
  })
end

return M
