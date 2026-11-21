local M = {}

function M.setup()
  local ok, fzf_lua = pcall(require, "fzf-lua")
  if not ok then
    return
  end

  fzf_lua.setup({})
  fzf_lua.register_ui_select()

  local ok_builtin, builtin = pcall(require, "fzf-lua.previewer.builtin")
  local image = require("config.autocmds.image")
  if ok_builtin and image.reconcile then
    local orig = builtin.base.set_preview_buf
    builtin.base.set_preview_buf = function(self, newbuf, min_winopts, no_wipe)
      orig(self, newbuf, min_winopts, no_wipe)
      local winid = self.win and self.win.preview_winid
      if winid and vim.api.nvim_win_is_valid(winid) then
        image.reconcile(winid)
      end
    end
  end
end

return M
