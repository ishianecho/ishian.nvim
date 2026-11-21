return {
  {
    src = "https://github.com/amitds1997/remote-nvim.nvim",
    dependencies = { "plenary.nvim", "nui.nvim" },
    cmd = { "RemoteStart", "RemoteStop", "RemoteInfo", "RemoteLog", "RemoteCleanup", "RemoteConfigDel" },
    config = function()
      require("config.editing.remote").setup()
    end,
  },
}
