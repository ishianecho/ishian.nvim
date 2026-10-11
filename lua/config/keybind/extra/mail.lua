return {
  {
    cond = function()
      return _G.UserUtils.plugin_installed("himalaya-vim9")
    end,
    { "<leader>m", "<Cmd>Himalaya<CR>", desc = "Mail (himalaya)" },
  },
}
