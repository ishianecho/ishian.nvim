return {
  {
    src = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    event = { "BufReadPost *.md", "BufNewFile *.md" },
    dependencies = { "nvim-treesitter" },
    config = function()
      require("config.editing.mdrender").setup()
    end,
  },
}
