local M = {}

local function apply(entry, parent)
  if type(entry.cond) == "function" and not entry.cond() then
    return
  end

  local mode = entry.mode or parent.mode
  local buffer = entry.buffer or parent.buffer
  local nowait = entry.nowait or parent.nowait

  local lhs, rhs = entry[1], entry[2]
  if type(lhs) == "string" and rhs ~= nil then
    vim.keymap.set(mode or "n", lhs, rhs, {
      buffer = buffer,
      desc = entry.desc,
      nowait = nowait,
      silent = true,
    })
  end

  for _, child in ipairs(entry) do
    if type(child) == "table" then
      apply(child, { mode = mode, buffer = buffer, nowait = nowait })
    end
  end
end

function M.add(spec)
  apply(spec, {})
end

function M.setup()
  if vim.g.vscode then
    M.add(require("config.keybind.vscode"))
    return
  end

  M.add({
    require("config.keybind.general"),
    require("config.keybind.langs"),
    require("config.keybind.editing"),
    require("config.keybind.extra"),
  })
end

return M
