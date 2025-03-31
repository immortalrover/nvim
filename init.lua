require("basic")
vim.opt.statusline = "%!v:lua.require('statusline').build()"
require("config.lazy")
