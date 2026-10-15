local M = {}

function M.setup()
  local ok, gitsigns = pcall(require, "gitsigns")
  if not ok then
    return
  end

  gitsigns.setup({
    on_attach = function(bufnr)
      if vim.bo[bufnr].filetype == "bigfile" then
        return false
      end
    end,
  })
end

return M
