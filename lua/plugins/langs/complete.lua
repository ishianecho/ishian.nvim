return {
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1"),
    config = function()
      require("config.langs.complete").setup()
    end,
  },
}
