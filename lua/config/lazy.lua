-- Define the path where lazy.nvim will be installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is already installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- Define the repository URL for lazy.nvim
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  -- Clone the repository if not installed
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none",
    "--branch=stable", lazyrepo, lazypath, })
  -- Handle cloning errors
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg", },
      { out,                            "WarningMsg", },
      { "\nPress any key to exit...", },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Set keymap to open lazy.nvim UI
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "打开lazy", })

-- Initialize lazy.nvim with configuration
require("lazy").setup({
  spec = {
    -- Import plugins from the plugins directory
    { import = "plugins", },
  },
  change_detection = {
    -- Enable automatic change detection
    enabled = true,
    -- Notify when changes are detected
    notify = true,
  },
})
