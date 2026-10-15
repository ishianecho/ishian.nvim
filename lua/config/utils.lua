local M = {}

function M.setup()
  _G.UserUtils = _G.UserUtils or {}

  function _G.UserUtils.plugin_installed(name)
    local plugin_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/" .. name
    return vim.fn.isdirectory(plugin_path) == 1
  end

  _G.UserUtils.autocmd_group = _G.UserUtils.autocmd_group
    or vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

  function _G.UserUtils.autocmd(event, opts)
    opts.group = _G.UserUtils.autocmd_group
    return vim.api.nvim_create_autocmd(event, opts)
  end
end

return M
