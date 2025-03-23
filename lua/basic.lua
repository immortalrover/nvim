local g = vim.g
local o = vim.opt
local k = vim.keymap
local a = vim.api

-- Set space as the leader key
g.mapleader = " "
-- Use global statusline
o.laststatus = 3
-- Show line numbers
o.number = true
-- Show relative line numbers
o.relativenumber = true
-- Highlight search results
o.hlsearch = true
-- Show search matches as you type
o.incsearch = true
-- Highlight current line
o.cursorline = true
-- Highlight current column
o.cursorcolumn = true
-- Enable true color support
o.termguicolors = true
-- Number of spaces that a tab counts for
o.tabstop = 4
-- Number of spaces to use for autoindent
o.shiftwidth = 4
-- Use spaces instead of tabs
o.expandtab = true
-- Smart tabbing
o.smarttab = true
-- Number of spaces that a tab counts for while editing
o.softtabstop = 4
-- Set encoding to UTF-8
o.encoding = "utf-8"
-- Show invisible characters
o.list = true
-- Define how to show invisible characters
o.listchars = {
  space = '·',
  trail = '-',
}
-- Set maximum text width
o.textwidth = 80

-- Set yank to system clipboard with leader+y
k.set({"n", "v"}, "<leader>y", [["+y]])
-- Set filetype specific options for nix and lua files

a.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.nix", "*.lua" },
  callback = function()
    -- Use 2 spaces for indentation in nix and lua files
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
