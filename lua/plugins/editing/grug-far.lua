return {
  {
    src = "https://github.com/MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },
    config = function()
      require("config.editing.grug-far").setup()
    end,
  },
}
