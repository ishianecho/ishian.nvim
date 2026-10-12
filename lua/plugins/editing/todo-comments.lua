return {
  {
    "folke/todo-comments.nvim",
    lazy = true,
    config = function()
      require("config.editing.todo-comments").setup()
    end,
  },
}
