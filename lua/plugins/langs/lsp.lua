return {
  {
    src = "https://github.com/neovim/nvim-lspconfig",
    dependencies = { "mason.nvim", "sqls.nvim" },
    config = function()
      require("config.langs.lsp.init").setup()
    end,
  },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/nanotee/sqls.nvim" },
  {
    src = "https://github.com/fatih/vim-go",
    ft = "go",
    init = function()
      vim.g.go_fmt_autosave = 1
      vim.g.go_highlight_types = 1
      vim.g.go_imports_mode = "goimports"
    end,
  },
  {
    src = "https://github.com/b0o/schemastore.nvim",
    ft = { "json", "yaml" },
  },
  {
    src = "https://github.com/mfussenegger/nvim-jdtls",
    ft = "java",
  },
  {
    src = "https://github.com/qvalentin/helm-ls.nvim",
    ft = "helm",
    config = function()
      require("config.langs.lsp.helm").setup()
    end,
  },
  {
    src = "https://github.com/ishianecho/nvim-mybatis",
    enabled = false,
    config = function()
      require("nvim-mybatis").setup({})
    end,
  },
  {
    src = "https://github.com/ishianecho/maa-pipeline.nvim",
    build = "npm install --include=dev && npm run build",
    config = function()
      require("config.langs.lsp.maa").setup()
    end,
  },
}
