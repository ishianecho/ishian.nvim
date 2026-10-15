local M = {}

local win = nil

local function close()
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
  win = nil
end

local highlights = {
  [vim.log.levels.ERROR] = "ErrorMsg",
  [vim.log.levels.WARN] = "WarningMsg",
}

function M.notify(msg, level)
  vim.schedule(function()
    close()

    msg = type(msg) == "table" and table.concat(msg, "\n") or tostring(msg)
    local lines = vim.split(msg, "\n", { plain = true })
    local width = 0
    for _, line in ipairs(lines) do
      width = math.max(width, vim.fn.strdisplaywidth(line))
    end
    width = math.min(math.max(width, 10) + 2, math.floor(vim.o.columns * 0.6))

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    win = vim.api.nvim_open_win(buf, false, {
      relative = "editor",
      anchor = "SE",
      row = vim.o.lines - 2,
      col = vim.o.columns - 1,
      width = width,
      height = #lines,
      style = "minimal",
      focusable = false,
      zindex = 50,
    })
    vim.api.nvim_set_option_value("winhl", "NormalFloat:" .. (highlights[level] or "NormalFloat"), { win = win })

    vim.defer_fn(close, 3000)
  end)
end

function M.setup()
  vim.notify = M.notify
end

return M
