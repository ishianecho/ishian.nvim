local M = {}

local conf = require("config.langs.lsp.shared")

local simple_servers = {
  {
    name = "clangd",
    cmd = "clangd",
    filetypes = { "c", "c.doxygen", "cpp", "cpp.doxygen", "objc", "objcpp", "cuda" },
  },
  {
    name = "cssls",
    cmd = "vscode-css-language-server",
    filetypes = { "css", "scss", "less" },
  },
  {
    name = "dockerls",
    cmd = "docker-langserver",
    filetypes = { "dockerfile" },
  },
  {
    name = "docker_compose_language_service",
    cmd = "docker-compose-langserver",
    filetypes = { "yaml.docker-compose" },
  },
  {
    name = "gh_actions_ls",
    cmd = "gh-actions-language-server",
    filetypes = { "yaml" },
  },
  { name = "groovyls", cmd = "groovy-language-server", filetypes = { "groovy" } },
  {
    name = "helm_ls",
    cmd = "helm_ls",
    filetypes = { "helm", "yaml.helm-values" },
  },
  {
    name = "html",
    cmd = "vscode-html-language-server",
    filetypes = { "html" },
  },
  { name = "kotlin_lsp", cmd = "intellij-server", filetypes = { "kotlin" } },
  {
    name = "marksman",
    cmd = "marksman",
    filetypes = { "markdown", "markdown.mdx" },
  },
  {
    name = "nginx_language_server",
    cmd = "nginx-language-server",
    filetypes = { "nginx" },
  },
  {
    name = "rust_analyzer",
    cmd = "rust-analyzer",
    filetypes = { "rust" },
  },
  { name = "taplo", cmd = "taplo", filetypes = { "toml" } },
  { name = "texlab", cmd = "texlab", filetypes = { "tex", "latex", "plaintex", "bib" } },
  { name = "tinymist", cmd = "tinymist", filetypes = { "typst" } },
  {
    name = "ts_query_ls",
    cmd = "ts_query_ls",
    filetypes = { "query" },
  },
}

local custom_confs = {
  {
    module = "bash",
    servers = {
      {
        name = "bashls",
        cmd = "bash-language-server",
        filetypes = { "bash", "sh", "zsh" },
      },
    },
  },
  {
    module = "go",
    servers = {
      {
        name = "gopls",
        cmd = "gopls",
        filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" },
      },
    },
  },
  {
    module = "java",
    servers = {
      {
        name = "jdtls",
        cmd = "jdtls",
        filetypes = { "java" },
      },
    },
  },
  {
    module = "js-family",
    servers = {
      {
        name = "ts_ls",
        cmd = "typescript-language-server",
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      },
      {
        name = "jsonls",
        cmd = "vscode-json-language-server",
        filetypes = { "json", "jsonc" },
      },
    },
  },
  {
    module = "lua",
    servers = {
      {
        name = "lua_ls",
        cmd = "lua-language-server",
        filetypes = { "lua" },
      },
    },
  },
  {
    module = "protobuf",
    servers = {
      { name = "buf_ls", cmd = "buf", filetypes = { "proto", "buf-config" } },
    },
  },
  {
    module = "python",
    servers = {
      { name = "ty", cmd = "ty", filetypes = { "python" } },
    },
  },
  {
    module = "sql",
    servers = {
      {
        name = "sqls",
        cmd = "sqls",
        filetypes = { "sql", "mysql" },
      },
    },
  },
  {
    module = "typos",
    servers = {
      {
        name = "typos_lsp",
        cmd = "typos-lsp",
        filetypes = "*",
      },
    },
  },
  {
    module = "vue",
    servers = {
      {
        name = "vtsls",
        cmd = "vtsls",
        filetypes = { "vue" },
      },
      {
        name = "vue_ls",
        cmd = "vue-language-server",
        filetypes = { "vue" },
      },
    },
  },
  {
    module = "xml",
    servers = {
      {
        name = "lemminx",
        cmd = "lemminx",
        filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
      },
    },
  },
  {
    module = "yaml",
    servers = {
      {
        name = "yamlls",
        cmd = "yaml-language-server",
        filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
      },
    },
  },
}

local servers_configured = false
local enabled_servers = {}

local function matches_filetype(filetypes, filetype)
  return filetypes == "*" or vim.tbl_contains(filetypes, filetype)
end

local function warn_missing(server, bufnr)
  local buf_missing = vim.b[bufnr].missing_lsp_notified or {}
  if buf_missing[server.cmd] then
    return
  end
  buf_missing[server.cmd] = true
  vim.b[bufnr].missing_lsp_notified = buf_missing
  vim.notify(("%s not found on PATH — run the chezmoi tool installer"):format(server.cmd), vim.log.levels.WARN)
end

local function get_lsp_for_filetype(filetype)
  local servers = {}
  local modules = {}

  for _, server in ipairs(simple_servers) do
    if matches_filetype(server.filetypes, filetype) then
      table.insert(servers, server)
    end
  end

  for _, item in ipairs(custom_confs) do
    local matched = false
    for _, server in ipairs(item.servers) do
      if matches_filetype(server.filetypes, filetype) then
        matched = true
        table.insert(servers, vim.tbl_extend("force", server, { module = item.module }))
      end
    end
    if matched then
      table.insert(modules, item)
    end
  end

  return servers, modules
end

local function setup_custom_module(item)
  local ok, module = pcall(require, "config.langs.lsp." .. item.module)
  if not ok then
    return false, module
  end

  local setup_ok, setup_result = pcall(module.setup)
  if not setup_ok or setup_result == false then
    return false, setup_result or "setup returned false"
  end
  return true
end

local function enable_server(server_name)
  if enabled_servers[server_name] then
    return
  end

  local ok, err = pcall(vim.lsp.enable, server_name)
  if not ok then
    vim.notify(("[LSP] Could not enable %s: %s"):format(server_name, err), vim.log.levels.ERROR)
    return
  end
  enabled_servers[server_name] = true
end

local function activate_lsp(filetype, bufnr)
  local servers, modules = get_lsp_for_filetype(filetype)

  local configured_modules = {}
  for _, item in ipairs(modules) do
    local module_ok, module_error = setup_custom_module(item)
    configured_modules[item.module] = module_ok
    if not module_ok then
      vim.notify(("[LSP] Could not configure %s: %s"):format(item.module, module_error), vim.log.levels.ERROR)
    end
  end

  for _, server in ipairs(servers) do
    if not server.module or configured_modules[server.module] then
      if vim.fn.executable(server.cmd) == 1 then
        enable_server(server.name)
      else
        warn_missing(server, bufnr)
      end
    end
  end
end

local function configure_servers()
  if servers_configured then
    return
  end

  for _, server in ipairs(simple_servers) do
    local ok, err = pcall(vim.lsp.config, server.name, {
      on_attach = conf.on_attach,
      capabilities = conf.capabilities,
    })
    if not ok then
      vim.notify(("[LSP] Could not configure %s: %s"):format(server.name, err), vim.log.levels.ERROR)
    end
  end

  servers_configured = true
end

function M.setup()
  configure_servers()

  local autocmd = _G.UserUtils.autocmd
  autocmd("FileType", {
    callback = function(args)
      local filetype = vim.bo[args.buf].filetype
      if filetype == "" then
        return
      end

      activate_lsp(filetype, args.buf)
    end,
  })
end

return M
