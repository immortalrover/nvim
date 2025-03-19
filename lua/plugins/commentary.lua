return {
  "tpope/vim-commentary",
  lazy = false,
  keys = {
    { "<leader>/", ":Commentary<cr>", mode = { "n", "v" }, desc = "注释代码" }
  }
}
