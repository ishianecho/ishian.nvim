local M = {}

local workspace = require("config.workspace")

local function platform_key()
  if vim.fn.has("win32") == 1 then
    return "windows"
  end
  if vim.fn.has("mac") == 1 then
    return "osx"
  end
  return "linux"
end

local function substitute(text)
  local file = vim.api.nvim_buf_get_name(0)
  local replacements = {
    ["${workspaceFolder}"] = workspace.root(),
    ["${file}"] = file,
    ["${fileDirname}"] = vim.fs.dirname(file),
  }
  for token, value in pairs(replacements) do
    if value then
      text = text:gsub(token:gsub("%W", "%%%1"), (value:gsub("%%", "%%%%")))
    end
  end
  return text
end

local function build_command(task)
  local command = task.command or ""
  local args = task.args or {}
  if type(command) == "table" then
    args = command
    command = table.remove(args, 1)
  end

  local override = task[platform_key()]
  if type(override) == "table" then
    if override.command then
      command = override.command
      args = override.args or args
    end
  end

  return substitute(vim.fn.join(vim.list_extend({ command }, args), " "))
end

local function run_task(task)
  local root = workspace.root()
  if not root then
    vim.notify("No .vscode workspace found", vim.log.levels.WARN)
    return
  end

  local command = build_command(task)
  local cwd = substitute(task.cwd or "${workspaceFolder}")
  vim.cmd("below new")
  local argv = vim.list_extend({ vim.o.shell }, vim.split(vim.o.shellcmdflag, "%s+", { trimempty = true }))
  table.insert(argv, command)
  vim.fn.termopen(argv, {
    cwd = cwd,
  })
end

function M.run(label)
  local tasks = vim.tbl_filter(function(task)
    return task.label and task.command and (task.type == nil or task.type == "shell")
  end, workspace.tasks())

  if vim.tbl_isempty(tasks) then
    vim.notify("No shell tasks in .vscode/tasks.json", vim.log.levels.WARN)
    return
  end

  local target
  if label ~= "" then
    target = vim.tbl_filter(function(task)
      return task.label == label
    end, tasks)[1]
  end
  if target then
    run_task(target)
    return
  end

  pcall(require, "fzf-lua")
  vim.ui.select(tasks, {
    prompt = "VS Code task:",
    format_item = function(task)
      return task.label
    end,
  }, function(choice)
    if choice then
      run_task(choice)
    end
  end)
end

return M
