return {
  "arzg/vim-colors-xcode",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme xcodedark")
    local a = vim.api
    a.nvim_set_hl(0, "StatusLineMode",
      { bg = "#665c54", fg = "#ebdbb2", italic = true, })
    a.nvim_set_hl(0, "StatusLineFile",
      { bg = "#665c54", fg = "#ebdbb2", italic = true, })
    a.nvim_set_hl(0, "StatusLineGit", { bg = "#434852", fg = "#FEFFFF", })
    a.nvim_set_hl(0, "StatusLinePath", {  fg = "#faa6ff", })
    -- a.nvim_set_hl(0, "StatusLineLSP", { bg = "#689d6a", fg = "#ebdbb2", })
    a.nvim_set_hl(0, "StatusLineEncoding", { fg = "#ebdbb2", })
    a.nvim_set_hl(0, "StatusLineLang", { fg = "#C6C8EE", })
  end,
}
