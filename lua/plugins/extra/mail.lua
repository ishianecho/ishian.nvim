return {
  {
    "pimalaya/himalaya-vim9",
    cmd = { "Himalaya", "HimalayaAccounts" },
    init = function()
      require("config.extra.mail").init()
    end,
    config = function()
      require("config.extra.mail").setup()
    end,
  },
}
