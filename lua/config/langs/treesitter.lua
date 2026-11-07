local M = {}

M.fts = {
  "bash",
  "c",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "doxygen",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "git_config",
  "git_rebase",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "graphql",
  "groovy",
  "helm",
  "html",
  "http",
  "java",
  "javadoc",
  "javascript",
  "jsdoc",
  "json5",
  "kotlin",
  "latex",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "nginx",
  "ninja",
  "printf",
  "powershell",
  "python",
  "query",
  "regex",
  "rust",
  "rst",
  "scala",
  "scss",
  "sql",
  "toml",
  "tsx",
  "typst",
  "typescript",
  "vim",
  "vimdoc",
  "vue",
  "xml",
  "yaml", -- GitHub Actions workflows use the YAML parser.
}

-- Filetypes whose parsers are built from local grammar repos and installed
-- into stdpath("data") .. "/site" manually, never fetched by nvim-treesitter.
M.local_fts = {
  "mybatis",
}

local local_filetypes = {
  pattern = {
    ["[%w.-]+[Mm]apper%.xml"] = "mybatis",
    ["[%w.-]*[Ss]ql[Mm]ap%.xml"] = "mybatis",
  },
}

function M.setup()
  local autocmd = _G.UserUtils.autocmd
  local treesitter = require("nvim-treesitter")
  local pending = {}

  vim.filetype.add(local_filetypes)

  local filetypes = vim.tbl_filter(function(filetype)
    return filetype ~= "powershell" or vim.fn.executable("pwsh") == 1
  end, M.fts)

  autocmd("FileType", {
    pattern = vim.list_extend(filetypes, M.local_fts),
    callback = function(args)
      local bufnr = args.buf
      local filetype = vim.bo[bufnr].filetype
      local language = vim.treesitter.language.get_lang(filetype) or filetype

      pending[language] = pending[language] or {}
      table.insert(pending[language], { bufnr = bufnr, filetype = filetype })

      if #pending[language] > 1 then
        return
      end

      if vim.list_contains(M.local_fts, filetype) then
        pending[language] = nil
        local loaded, err = vim.treesitter.language.add(language)
        if not loaded then
          vim.notify(("[Treesitter] Could not load %s: %s"):format(language, err or "unknown error"), vim.log.levels.ERROR)
          return
        end
        local ok, start_err = pcall(vim.treesitter.start, bufnr, language)
        if not ok then
          vim.notify(("[Treesitter] Could not start %s: %s"):format(language, start_err), vim.log.levels.WARN)
        end
        return
      end

      local ok, task = pcall(treesitter.install, { language })
      if not ok then
        pending[language] = nil
        vim.notify(("[Treesitter] Could not install %s: %s"):format(language, task), vim.log.levels.ERROR)
        return
      end

      task:await(function(err, installed)
        vim.schedule(function()
          local buffers = pending[language]
          pending[language] = nil

          if err or installed == false then
            vim.notify(
              ("[Treesitter] Could not install %s: %s"):format(language, err or "unknown error"),
              vim.log.levels.ERROR
            )
            return
          end

          for _, item in ipairs(buffers or {}) do
            if vim.api.nvim_buf_is_valid(item.bufnr) and vim.bo[item.bufnr].filetype == item.filetype then
              local bufnr = item.bufnr
              if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype == "" then
                return
              end

              local loaded, err = vim.treesitter.language.add(language)
              if not loaded then
                vim.notify(
                  ("[Treesitter] Could not load %s: %s"):format(language, err or "unknown error"),
                  vim.log.levels.WARN
                )
                return
              end

              local ok, start_err = pcall(vim.treesitter.start, bufnr, language)
              if not ok then
                vim.notify(("[Treesitter] Could not start %s: %s"):format(language, start_err), vim.log.levels.WARN)
              end
            end
          end
        end)
      end)
    end,
  })
end

return M
