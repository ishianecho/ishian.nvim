return {
  {
    "nvim-mini/mini.move",
    config = function()
      require("config.editing.move").setup()
    end,
  },
}
