return {
  {
    src = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("config.editing.mdrender").setup()
    end,
  },
}
