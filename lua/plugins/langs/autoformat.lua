return {
  {
    src = "https://github.com/stevearc/conform.nvim",
    config = function()
      require("config.langs.autoformat").setup()
    end,
  },
}
