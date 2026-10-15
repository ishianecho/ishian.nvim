local M = {}
local setup_done = false

local function is_sql_buffer(bufnr)
  local filetype = vim.bo[bufnr].filetype
  return filetype == "sql" or filetype == "mysql"
end

local function add_buffer_keybinds(bufnr)
  if not is_sql_buffer(bufnr) then
    return
  end

  if vim.b[bufnr].database_keybind_kind == "sqls" then
    return
  end
  vim.b[bufnr].database_keybind_kind = "sqls"

  require("config.keybind").add({
    {
      buffer = bufnr,
      {
        "<leader>dc",
        "<Cmd>SqlsSwitchConnection<CR>",
        desc = "Switch SQL connection",
      },
      {
        "<leader>db",
        "<Cmd>SqlsSwitchDatabase<CR>",
        desc = "Switch SQL database",
      },
      {
        "<leader>dx",
        "<Cmd>SqlsExecuteQuery<CR>",
        desc = "Execute query with SQLS",
      },
      {
        "<leader>dx",
        "<Cmd>'<,'>SqlsExecuteQuery<CR>",
        mode = "x",
        desc = "Execute selection with SQLS",
      },
    },
  })
end

function M.setup()
  if setup_done then
    return
  end
  setup_done = true

  _G.UserUtils.autocmd({ "BufEnter", "FileType" }, {
    callback = function(args)
      add_buffer_keybinds(args.buf)
    end,
  })

  add_buffer_keybinds(vim.api.nvim_get_current_buf())
end

return M
