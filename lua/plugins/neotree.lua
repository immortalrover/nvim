return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = true,
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
  },
  keys = {
    {
      "<leader>e",
      ":Neotree toggle reveal_force_cwd<cr>\
      :set relativenumber<CR>",
      desc = "打开文件树",
    },
    {
      "<leader>gs",
      ":Neotree close<cr>\
      :Neotree float git_status<cr>\
      :set relativenumber<CR>",
      desc = "Show the output of `git status` in a tree layout.",
    },
  },
}
