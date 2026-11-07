local conf = require("config.langs.lsp.shared")
local M = {}

local plugin_notified = false

local function resolve_plugin_location()
  local candidates = {}
  local npm_root = vim.trim(vim.fn.system({ "npm", "root", "-g" }))
  if vim.v.shell_error == 0 and npm_root ~= "" then
    table.insert(candidates, npm_root .. "/@vue/language-server")
  end
  vim.list_extend(
    candidates,
    vim.fn.glob(
      vim.fs.normalize("~/.local/share/mise/installs/npm/**/node_modules/@vue/language-server"),
      false,
      true
    )
  )
  for _, path in ipairs(candidates) do
    if vim.fn.isdirectory(path) == 1 then
      return path
    end
  end
  return nil
end

function M.setup()
  local vue_path = resolve_plugin_location()
  if not vue_path and not plugin_notified then
    plugin_notified = true
    vim.notify("@vue/typescript-plugin not found; vtsls vue template support disabled", vim.log.levels.WARN)
  end

  local global_plugins = vue_path and {
    {
      name = "@vue/typescript-plugin",
      location = vue_path,
      languages = { "vue" },
      configNamespace = "typescript",
    },
  } or nil

  vim.lsp.config("vtsls", {
    on_attach = conf.on_attach,
    capabilities = conf.capabilities,
    filetypes = { "vue" },
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = global_plugins,
        },
      },
    },
  })

  vim.lsp.config("vue_ls", {
    on_attach = conf.on_attach,
    capabilities = conf.capabilities,
    filetypes = { "vue" },
    init_options = {
      hybridMode = true,
    },
  })
end

return M
