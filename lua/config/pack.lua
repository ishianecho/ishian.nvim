local M = {}

local sources = {
  "plugins.langs.autoformat",
  "plugins.langs.complete",
  "plugins.langs.linter",
  "plugins.langs.lsp",
  "plugins.langs.treesitter",
  "plugins.editing.grug-far",
  "plugins.editing.move",
  "plugins.editing.pairs",
  "plugins.ui.bufferline",
  "plugins.ui.colortheme",
  "plugins.ui.fzf",
  "plugins.ui.neotree",
  "plugins.ui.noice",
  "plugins.editing.git",
  "plugins.editing.markdown",
}

local shared = {
  ["nvim-web-devicons"] = "https://github.com/nvim-tree/nvim-web-devicons",
  ["plenary.nvim"] = "https://github.com/nvim-lua/plenary.nvim",
  ["nui.nvim"] = "https://github.com/MunifTanjim/nui.nvim",
}

local order = {}
local specs = {}
local loaded = {}
local added = {}

local function lazy(spec)
  return spec.cmd ~= nil or spec.ft ~= nil or spec.event ~= nil
end

local function register(spec)
  if spec.enabled == false then
    return
  end
  spec.name = spec.name or spec.src:match("[^/]+$"):gsub("%.git$", "")
  spec.seq = #order + 1
  table.insert(order, spec)
  specs[spec.name] = spec
end

function M.load(name)
  local spec = specs[name]
  if not spec and shared[name] then
    register({ src = shared[name] })
    spec = specs[name]
  end
  if not spec then
    error("Unknown plugin: " .. name, 2)
  end
  if loaded[name] then
    return
  end
  loaded[name] = true

  for _, dependency in ipairs(spec.dependencies or {}) do
    M.load(dependency)
  end
  if spec.init then
    spec.init()
  end
  if added[name] then
    vim.cmd.packadd(name)
  else
    vim.pack.add({ { src = spec.src, name = spec.name, version = spec.version } }, { confirm = false })
    added[name] = true
  end
  if spec.config then
    spec.config()
  end
end

local function attach_cmd(spec)
  local commands = type(spec.cmd) == "table" and spec.cmd or { spec.cmd }
  for _, command in ipairs(commands) do
    vim.api.nvim_create_user_command(command, function(args)
      vim.api.nvim_del_user_command(command)
      M.load(spec.name)
      local opts = { cmd = command, args = args.fargs, bang = args.bang }
      if args.range > 0 then
        opts.range = { args.line1, args.line2 }
      end
      vim.api.nvim_cmd(opts, {})
    end, { nargs = "*", bang = true, range = true })
  end
end

local function attach_filetype(spec)
  local filetypes = type(spec.ft) == "table" and spec.ft or { spec.ft }
  _G.UserUtils.autocmd("FileType", {
    pattern = filetypes,
    callback = function(args)
      if loaded[spec.name] then
        return
      end
      M.load(spec.name)
      if vim.bo[args.buf].filetype == args.match then
        vim.api.nvim_exec_autocmds("FileType", { buffer = args.buf })
      end
    end,
  })
end

local function attach_event(spec)
  local events = type(spec.event) == "table" and spec.event or { spec.event }
  for _, event in ipairs(events) do
    local name, pattern = event:match("^(%S+)%s*(.*)$")
    if name == "VeryLazy" then
      name, pattern = "UIEnter", nil
    end
    _G.UserUtils.autocmd(name, {
      pattern = pattern ~= "" and pattern or nil,
      callback = function(args)
        if loaded[spec.name] then
          return
        end
        M.load(spec.name)
        if args.buf then
          vim.api.nvim_exec_autocmds(name, { buffer = args.buf })
        end
      end,
    })
  end
end

local function attach_require()
  local providers = {}
  for _, spec in ipairs(order) do
    if lazy(spec) then
      providers[spec.name] = spec.name
      providers[spec.name:gsub("%.nvim$", "")] = spec.name
    end
  end

  table.insert(package.loaders, 1, function(module)
    local name = providers[module] or providers[module:match("^[^.]+")]
    if name and not loaded[name] then
      M.load(name)
    end
    return nil
  end)
end

function M.setup()
  local builds = {}

  for _, source in ipairs(sources) do
    for _, spec in ipairs(require(source)) do
      register(spec)
      if spec.build then
        builds[spec.name] = spec.build
      end
    end
  end

  if next(builds) then
    _G.UserUtils.autocmd("PackChanged", {
      callback = function(ev)
        local build = builds[ev.data.spec.name]
        if build and (ev.data.kind == "install" or ev.data.kind == "update") then
          vim.system({ "sh", "-c", build }, { cwd = ev.data.path })
        end
      end,
    })
  end

  local eager = vim.tbl_filter(function(spec)
    return not lazy(spec)
  end, order)
  table.sort(eager, function(a, b)
    local ap, bp = a.priority or 0, b.priority or 0
    if ap ~= bp then
      return ap > bp
    end
    return a.seq < b.seq
  end)
  for _, spec in ipairs(eager) do
    M.load(spec.name)
  end

  for _, spec in ipairs(order) do
    if lazy(spec) and not loaded[spec.name] then
      if spec.cmd then
        attach_cmd(spec)
      end
      if spec.ft then
        attach_filetype(spec)
      end
      if spec.event then
        attach_event(spec)
      end
    end
  end

  _G.UserUtils.autocmd("UIEnter", {
    callback = function()
      local pending = {}
      for _, spec in ipairs(order) do
        if not added[spec.name] then
          table.insert(pending, { src = spec.src, name = spec.name, version = spec.version })
          added[spec.name] = true
        end
      end
      if #pending > 0 then
        vim.pack.add(pending, { load = false, confirm = false })
      end
    end,
  })

  attach_require()
end

return M
