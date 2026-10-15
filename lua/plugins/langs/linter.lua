return {
  {
    src = "https://github.com/mfussenegger/nvim-lint",
    config = function()
      require("config.langs.linter").setup()
    end,
  },
}
