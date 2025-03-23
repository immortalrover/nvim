-- Return the Neo-tree plugin configuration
return {
  -- Neo-tree plugin repository
  "nvim-neo-tree/neo-tree.nvim",
  -- Use v3.x branch
  branch = "v3.x",
  -- List of dependencies
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  -- Load plugin lazily
  lazy = true,
  -- Module type annotation
  ---@module "neo-tree"
  -- Optional configuration type
  ---@type neotree.Config?
  -- Empty options table
  opts = {
  },
  -- Key mappings configuration
  keys = {
    {
      -- Toggle file tree with leader + e
      "<leader>e",
      -- Command to toggle Neo-tree and set relative numbers
      ":Neotree toggle reveal_force_cwd<cr>\
      :set relativenumber<CR>",
      -- Description in Chinese: "打开文件树"
      desc = "打开文件树",
    },
    {
      -- Show git status with leader + gs
      "<leader>gs",
      -- Command to close current tree and open git status in floating window
      ":Neotree close<cr>\
      :Neotree float git_status<cr>\
      :set relativenumber<CR>",
      -- Description of the git status tree layout
      desc = "Show the output of `git status` in a tree layout.",
    },
  },
}
