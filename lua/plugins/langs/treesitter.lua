return {
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
    config = function()
      require("config.langs.treesitter").setup()
    end,
  },
}
