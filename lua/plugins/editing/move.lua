return {
  {
    src = "https://github.com/nvim-mini/mini.move",
    config = function()
      require("config.editing.move").setup()
    end,
  },
}
