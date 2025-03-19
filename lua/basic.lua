local g = vim.g
local o = vim.opt
local k = vim.keymap
local a = vim.api

g.mapleader = " "
o.number = true
o.relativenumber = true
o.hlsearch = true
o.incsearch = true
o.cursorline = true
o.cursorcolumn = true
o.termguicolors = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smarttab = true
o.softtabstop = 4
o.encoding = "utf-8"
o.list = true
o.listchars = {
  space = '·',
  trail = '-',
}
o.textwidth = 80
k.set({"n", "v"}, "<leader>y", [["+y]])

a.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.nix", "*.lua" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
