local M = {}

function M.foldtext()
  local start, end_lnum = vim.v.foldstart, vim.v.foldend
  local text = vim.fn.getline(start):gsub("\t", string.rep(" ", vim.bo.tabstop))
  local leader = (vim.bo.commentstring or ""):gsub("%%s.*", ""):gsub("%s+$", "")
  if leader ~= "" then
    text = text:gsub("^%s*" .. vim.pesc(leader) .. "%s*", "")
  else
    text = text:gsub("^%s+", "")
  end
  text = text:gsub("%s+$", "")
  if text == "" then
    text = "{empty}"
  end
  return string.format(" [%d lines] %s", end_lnum - start + 1, text)
end

function M.setup()
  _G.UserUtils.autocmd("BufWinEnter", {
    callback = function(args)
      local bufnr = args.buf
      if vim.bo[bufnr].buftype ~= "" or vim.b[bufnr].bigfile then
        return
      end

      local win = vim.api.nvim_get_current_win()
      if not vim.tbl_contains(require("config.langs.treesitter").fts, vim.bo[bufnr].filetype) then
        vim.wo[win].foldmethod = "indent"
        return
      end

      vim.wo[win].foldmethod = "expr"
      vim.wo[win].foldexpr = "v:lua.require'vim.treesitter'.foldexpr()"

      local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
      if not ok or not parser then
        return
      end
      local parsed = { pcall(function()
        return parser:parse()
      end) }
      local tree = parsed[1] and parsed[2] and parsed[2][1]
      if not tree then
        return
      end

      local stack = { tree:root() }
      while #stack > 0 do
        local node = table.remove(stack)
        for child in node:iter_children() do
          local node_type = child:type()
          local start_row = child:start()
          local end_row = (child:end_())
          if end_row > start_row and (node_type:find("^import") or node_type:find("comment")) then
            vim.api.nvim_win_call(win, function()
              vim.api.nvim_win_set_cursor(win, { start_row + 1, 0 })
              vim.cmd("silent! normal! zc")
            end)
          else
            table.insert(stack, child)
          end
        end
      end
    end,
  })
end

return M
