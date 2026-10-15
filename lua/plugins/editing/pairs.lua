return {
  {
    src = "https://github.com/windwp/nvim-autopairs",
    config = function()
      require("config.editing.autopairs").setup()
    end,
  },
}
