local conf = require("config.langs.lsp.shared")
local M = {}

function M.setup()
  local ok, schemastore = pcall(require, "schemastore")
  local schemas = vim.list_extend({}, require("config.workspace").json_schemas())
  if ok then
    vim.list_extend(schemas, schemastore.json.schemas())
  end

  vim.lsp.config("ts_ls", {
    on_attach = conf.on_attach,
    capabilities = conf.capabilities,
  })

  vim.lsp.config("jsonls", {
    on_attach = conf.on_attach,
    capabilities = conf.capabilities,
    settings = {
      json = {
        schemas = schemas,
        validate = { enable = true },
      },
    },
  })
end

return M
