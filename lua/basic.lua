local g = vim.g
local o = vim.opt
local k = vim.keymap
local a = vim.api

-- Set space as the leader key
g.mapleader = " "
o.laststatus = 3
-- o.statusline = "%!v:lua.require'statusline'.build()"
o.showmode = false
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
o.foldmethod = "indent"
-- o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = false
o.foldlevel = 99
-- Set yank to system clipboard with leader+y
k.set({"n", "v"}, "<leader>y", [["+y]])
-- Set filetype specific options for nix and lua files

-- 定义快捷键 <leader>r 重新加载配置（并显示提示）
k.set('n', '<leader>r', function()
  -- 重新加载 Lua 配置文件
  vim.cmd('luafile ' .. vim.env.MYVIMRC)
  -- 显示提示信息（Neovim 0.8+ 支持 vim.notify）
  vim.notify('配置已重新加载！', vim.log.levels.INFO)
end, { desc = '重新加载 Neovim 配置' })

k.set('n', 'v', [[m'v]])
k.set('v', '<Esc>', [[<Esc>`']])

a.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.nix", "*.lua" },
  callback = function()
    -- Use 2 spaces for indentation in nix and lua files
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

