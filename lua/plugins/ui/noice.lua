return {
  {
    src = "https://github.com/folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "nui.nvim" },
    config = function()
      require("config.ui.noice").setup()
    end,
  },
}
