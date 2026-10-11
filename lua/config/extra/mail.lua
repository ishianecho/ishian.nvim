local M = {}

function M.init()
  vim.g.himalaya_account_picker = "fzflua"
  vim.g.himalaya_folder_picker = "fzflua"
end

function M.setup()
  local autocmd = _G.UserUtils.autocmd

  autocmd("FileType", {
    pattern = { "himalaya-email-listing", "mail" },
    callback = function(args)
      local bufnr = args.buf
      local map = vim.keymap.set

      if args.match == "himalaya-email-listing" then
        map({ "n", "x" }, "d", "<Plug>(himalaya-email-delete)", { buffer = bufnr, nowait = true, desc = "Delete email" })
        map({ "n", "x" }, "u", "<Plug>(himalaya-email-flag-remove)", { buffer = bufnr, nowait = true, desc = "Remove flag (e.g. seen)" })
        map("n", "r", "<Plug>(himalaya-email-reply)", { buffer = bufnr, nowait = true, desc = "Reply" })
        map("n", "a", "<Plug>(himalaya-email-reply-all)", { buffer = bufnr, nowait = true, desc = "Reply all" })
        map("n", "f", "<Plug>(himalaya-email-forward)", { buffer = bufnr, nowait = true, desc = "Forward" })
        map("n", "m", "<Plug>(himalaya-email-write)", { buffer = bufnr, nowait = true, desc = "Write new email" })
        map("n", "/", "<Plug>(himalaya-set-list-envelopes-query)", { buffer = bufnr, nowait = true, desc = "Filter envelopes" })
        map("n", "q", function() pcall(vim.cmd, "close") end, { buffer = bufnr, nowait = true, desc = "Quit" })
      elseif vim.bo[bufnr].buftype == "nofile" then
        map("n", "d", "<Plug>(himalaya-email-delete)", { buffer = bufnr, nowait = true, desc = "Delete email" })
        map("n", "r", "<Plug>(himalaya-email-reply)", { buffer = bufnr, nowait = true, desc = "Reply" })
        map("n", "a", "<Plug>(himalaya-email-reply-all)", { buffer = bufnr, nowait = true, desc = "Reply all" })
        map("n", "f", "<Plug>(himalaya-email-forward)", { buffer = bufnr, nowait = true, desc = "Forward" })
        map("n", "o", "<Plug>(himalaya-email-open-browser)", { buffer = bufnr, nowait = true, desc = "Open in browser" })
        map("n", "q", function() pcall(vim.cmd, "close") end, { buffer = bufnr, nowait = true, desc = "Quit" })
      end
    end,
  })
end

return M
