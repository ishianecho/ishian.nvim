return {
  {
    cond = function()
      return _G.UserUtils.plugin_installed("claudecode.nvim")
    end,
    { "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<CR>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<CR>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<CR>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<CR>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<CR>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<CR>", mode = "x", desc = "Send to Claude" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Deny diff" },
  },
}
