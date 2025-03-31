return {
  "echasnovski/mini.map",
  version = "*",
  config = function()
    local k = vim.keymap
    local minimap = require("mini.map")
    minimap.setup({ symbols = { encode = minimap.gen_encode_symbols.dot("4x2"), }, })
    minimap.open()
    k.set("n", "<Leader>mc", minimap.close, { desc = "Close map window", })
    k.set("n", "<Leader>mf", minimap.toggle_focus,
      { desc = "Toggle focus to/from map window", })
    k.set("n", "<Leader>mo", minimap.open, { desc = "Open map window", })
    k.set("n", "<Leader>mr", minimap.refresh, { desc = "Refresh map window", })
    k.set("n", "<Leader>ms", minimap.toggle_side,
      { desc = "Toggle side of map window", })
    k.set("n", "<Leader>mt", minimap.toggle, { desc = "Toggle map window", })
  end,
}
