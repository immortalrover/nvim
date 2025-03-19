return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = { "LazyGit" },
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "打开LazyGit" }
  },
}
