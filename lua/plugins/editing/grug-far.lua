return {
  {
    "MagicDuck/grug-far.nvim",
    lazy = true,
    cmd = { "GrugFar", "GrugFarWithin" },
    config = function()
      require("config.editing.grug-far").setup()
    end,
  },
}
