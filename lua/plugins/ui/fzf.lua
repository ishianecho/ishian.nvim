return {
  {
    src = "https://github.com/ibhagwan/fzf-lua",
    dependencies = { "nvim-web-devicons" },
    config = function()
      require("config.ui.fzf").setup()
    end,
  },
}
