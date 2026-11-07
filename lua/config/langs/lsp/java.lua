local conf = require("config.langs.lsp.shared")
local M = {}

local function resolve_java_home()
  if vim.env.JAVA_HOME and vim.env.JAVA_HOME ~= "" then
    return vim.env.JAVA_HOME, nil
  end
  if vim.fn.has("win32") == 1 then
    local java_path = vim.fn.exepath("java")
    if java_path ~= "" then
      local java_home = vim.fs.dirname(vim.fs.dirname(java_path))
      if vim.fn.isdirectory(java_home) == 1 then
        return java_home, nil
      end
    end
  end
  if vim.fn.executable("/usr/libexec/java_home") == 1 then
    local home = vim.trim(vim.fn.system({ "/usr/libexec/java_home" }))
    if vim.v.shell_error == 0 and home ~= "" then
      return home, nil
    end
  end
  return nil, nil
end

local function resolve_java_runtimes()
  local java_home, version = resolve_java_home()
  if not java_home then
    return {}
  end
  return {
    {
      name = "JavaSE-" .. (version or "21"),
      path = java_home,
    },
  }
end

local function resolve_jdtls_java_home()
  local best
  local installs = vim.fn.glob(vim.fn.expand("~/.local/share/mise/installs/java/*"), false, true)
  for _, dir in ipairs(installs) do
    if vim.fn.isdirectory(dir) == 1 then
      local version = vim.version.parse(vim.fs.basename(dir):gsub("^openjdk%-", ""))
      if version and version.major >= 25 and (not best or vim.version.gt(version, best.version)) then
        best = { version = version, path = dir }
      end
    end
  end
  return best and best.path or nil
end

function M.setup()
  local jdtls_java_home = resolve_jdtls_java_home()

  vim.lsp.config("jdtls", {
    on_attach = function(client, bufnr)
      conf.on_attach(client, bufnr)
      local jdtls = require("jdtls")
      vim.keymap.set("n", "<leader>co", function()
        jdtls.organize_imports()
      end, {
        buffer = bufnr,
        desc = "Organize Imports",
      })
    end,
    capabilities = conf.capabilities,
    cmd_env = jdtls_java_home and { JAVA_HOME = jdtls_java_home } or nil,
    settings = {
      java = {
        configuration = {
          runtimes = resolve_java_runtimes(),
        },
        signatureHelp = {
          enabled = true,
        },
        inlayHint = {
          enabled = true,
        },
      },
    },
    init_options = {
      extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
        refresh = {
          enabled = true,
        },
      },
    },
  })
end

return M
