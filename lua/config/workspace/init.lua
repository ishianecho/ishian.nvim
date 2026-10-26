local M = {}

local root
local schema_entries = {}

local function decode_jsonc(path)
  if vim.fn.filereadable(path) == 0 then
    return nil
  end
  local text = table.concat(vim.fn.readfile(path), "\n")
  local ok, data = pcall(vim.json.decode, text, { skip_comments = true })
  if not ok then
    ok, data = pcall(vim.json.decode, text:gsub(",(%s*[}%]])", "%1"), { skip_comments = true })
  end
  if ok and type(data) == "table" then
    return data
  end
  return nil
end

local function glob_to_pattern(glob)
  local pattern = {}
  local i = 1
  while i <= #glob do
    local char = glob:sub(i, i)
    if char == "*" then
      if glob:sub(i + 1, i + 1) == "*" then
        if glob:sub(i + 2, i + 2) == "/" then
          table.insert(pattern, "(.*/)?")
          i = i + 2
        else
          table.insert(pattern, ".*")
          i = i + 1
        end
      else
        table.insert(pattern, "[^/]*")
      end
    elseif char == "?" then
      table.insert(pattern, "[^/]")
    else
      table.insert(pattern, (char:gsub("[%^^$()%.%[%]*+%-%?]", "%%%1")))
    end
    i = i + 1
  end
  return ".*" .. table.concat(pattern)
end

local function load_root(new_root)
  root = new_root
  schema_entries = {}

  local settings = decode_jsonc(root .. "/.vscode/settings.json")
  if type(settings) == "table" then
    local patterns = {}
    for glob, language in pairs(settings["files.associations"] or {}) do
      patterns[glob_to_pattern(glob)] = language
    end
    if next(patterns) then
      vim.filetype.add({ pattern = patterns })
    end

    for _, entry in ipairs(settings["json.schemas"] or {}) do
      local path = entry.url and entry.url:sub(1, 1) == "/" and root .. entry.url or entry.url
      local schema = decode_jsonc(path)
      if schema and entry.fileMatch then
        local file_match = {}
        for _, glob in ipairs(entry.fileMatch) do
          if glob:sub(1, 1) == "!" then
            table.insert(file_match, "!" .. (glob:sub(2):gsub("^/", "**/")))
          else
            table.insert(file_match, (glob:gsub("^/", "**/")))
          end
        end
        table.insert(schema_entries, { fileMatch = file_match, schema = schema })
      end
    end
  end
end

local function current_source()
  local name = vim.api.nvim_buf_get_name(0)
  if name ~= "" then
    return name
  end
  return vim.fn.getcwd()
end

local function refresh()
  local new_root = vim.fs.root(current_source(), ".vscode")
  if new_root and new_root ~= root then
    load_root(new_root)
  end
end

function M.root()
  refresh()
  return root
end

function M.json_schemas()
  refresh()
  return schema_entries
end

function M.tasks()
  refresh()
  if not root then
    return {}
  end
  local tasks = decode_jsonc(root .. "/.vscode/tasks.json")
  return type(tasks) == "table" and tasks.tasks or {}
end

function M.setup()
  refresh()

  _G.UserUtils.autocmd({ "BufReadPre", "BufNewFile" }, {
    callback = function()
      refresh()
    end,
  })

  _G.UserUtils.autocmd("DirChanged", {
    callback = function()
      load_root(nil)
      refresh()
    end,
  })

  local tasks = require("config.workspace.tasks")
  vim.api.nvim_create_user_command("Task", function(args)
    tasks.run(args.args)
  end, { nargs = "?", desc = "Run a task from .vscode/tasks.json" })
end

return M
