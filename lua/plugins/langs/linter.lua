return {
  {
    src = "https://github.com/mfussenegger/nvim-lint",
    event = "BufReadPost",
    config = function()
      require("config.langs.linter").setup()
    end,
  },
}
