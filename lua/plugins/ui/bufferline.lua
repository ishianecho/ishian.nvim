return {
  {
    src = "https://github.com/akinsho/bufferline.nvim",
    dependencies = { "nvim-web-devicons" },
    config = function()
      require("config.ui.bufferline").setup()
    end,
  },
}
