local M = {}

function M.build()
  local parts = {
    M.mode(),
    -- M.file_info(),
    -- M.git_status(),
    -- M.lsp_status(),
    -- M.line_col(),
  }
  return table.concat(parts, " ")
end

function M.mode()
  local mode_map = {
    n = "norm",
    i = "inst",
    v = "visl",
    V = "visl",
    c = "comd",
  }
  local mode = mode_map[vim.fn.mode()]
  return "%#StatusLineMode# " .. mode .. " %*"
end

vim.api.nvim_set_hl(0, "StatusLineMode", {
  italic = true,
})

return M
