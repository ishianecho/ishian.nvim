return {
  {
    "windwp/nvim-autopairs",
    config = function()
      require("config.editing.autopairs").setup()
    end,
  },
}
