return {
  {
    src = "https://github.com/lewis6991/gitsigns.nvim",
    config = function()
      require("config.editing.gitsigns").setup()
    end,
  },
  {
    src = "https://github.com/NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = { "plenary.nvim", "diffview.nvim" },
    config = function()
      require("config.editing.neogit").setup()
    end,
  },
  {
    src = "https://github.com/sindrets/diffview.nvim",
    config = function()
      require("config.editing.diffview").setup()
    end,
  },
  {
    src = "https://github.com/pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = { "plenary.nvim", "fzf-lua" },
    config = function()
      require("config.editing.octo").setup()
    end,
  },
}
