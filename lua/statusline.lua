local M = {}

function M.build()
  local parts = {
    M.mode(),
    M.filename(),
    "%=",
    M.git_status(),
    M.lsp_status(),
    M.file_encoding(),
    M.filetype_icon(),
    M.filepath(),
  }
  return table.concat(parts, " ")
end

function M.mode()
  local mode_map = {
    R = "repl",
    S = "slct",
    V = "line",
    c = "comd",
    i = "inst",
    n = "norm",
    r = "eter",
    s = "slct",
    t = "term",
    v = "visl",
    Rc = "repl",
    Rv = "vrep",
    Vs = "line",
    ce = "comd",
    cv = "comd",
    ic = "inst",
    ix = "inst",
    no = "op",
    nt = "term",
    rm = "more",
    vs = "visl",
    niI = "norm",
    niR = "norm",
    niV = "norm",
    noV = "op",
    nov = "op",
    null = "none",
    [""] = "blck",
    [""] = "blck",
    ["s"] = "block",
    ["!"] = "shel",
    [""] = "blck",
    ["Rx"] = "repl",
    ["no"] = "op",
    ["r?"] = "cnfm",
  }
  local mode = mode_map[vim.fn.mode()] or "unkn"
  return "%#StatusLineMode# " .. mode .. " %*"
end

function M.filename()
  local name = vim.fn.expand("%:t") -- 获取文件名（不含路径）
  if name == "" then name = "[No Name]" end
  local modified = vim.bo.modified and " ●" or ""
  return "%#StatusLineFile# " .. name .. modified .. " %*"
end

local git_branch_cache = "" -- 缓存分支名

local function update_git_branch()
  vim.fn.jobstart("git branch --show-current", {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data and data[1] then
        git_branch_cache = data[1]:gsub("%s+", "")
      else
        git_branch_cache = ""
      end
    end,
  })
end

-- 定时更新分支（每 5 秒）
vim.loop.new_timer():start(0, 5000, vim.schedule_wrap(update_git_branch))

function M.git_status()
  if git_branch_cache ~= "" then
    return "%#StatusLineGit#  " .. git_branch_cache .. " %*"
  else
    return ""
  end
end

function M.lsp_status()
  local status_ok, msg = pcall(vim.lsp.status)
  if status_ok and msg ~= "" then
    return "%#StatusLineLSP#  " .. msg .. " %*"
  end
  return ""
end

function M.file_encoding()
  local encoding = vim.bo.fileencoding
  encoding = encoding ~= '' and encoding or 'utf-8'
  return "%#StatusLineEncoding#  " .. encoding .. " %*"
end

function M.filepath()
  local path = vim.fn.expand("%:h") -- 获取文件所在目录
  if path == "." then return "" end -- 根目录时不显示
  -- 缩短家目录显示为 ~
  path = path:gsub("^" .. os.getenv("HOME"), "~")
  -- 缩短路径显示（只保留最后两级）
  local parts = {}
  for part in path:gmatch("[^/]+") do
    table.insert(parts, part)
  end
  if #parts > 2 then
    path = "…/" .. table.concat(parts, "/", #parts - 1)
  end
  return "%#StatusLinePath# " .. path .. "/ %*"
end

function M.filetype_icon()
  local filetypes = {
    python = "",
    javascript = "",
    typescript = "",
    java = "",
    cpp = "",
    lua = "",
    rust = "",
    go = "",
    html = "",
    css = "",
    json = "",
    markdown = "",
    bash = "",
    vim = "",
  }
  local ft = vim.bo.filetype
  local icon = filetypes[ft] or ""
  return icon ~= "" and ("%#StatusLineLang# " .. icon .. " %*") or ""
end

return M
