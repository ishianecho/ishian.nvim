return {
  {
    src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
    version = "v3.x",
    dependencies = { "plenary.nvim", "nvim-web-devicons", "nui.nvim" },
    config = function()
      require("config.ui.neotree").setup()
    end,
  },
}
