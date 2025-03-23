return {
  -- Plugin specification for avante.nvim
  "yetone/avante.nvim",
  -- Load the plugin very lazily
  event = "VeryLazy",
  -- Version specification (never use "*")
  version = false,
  -- Configuration options for the plugin
  opts = {
    -- Set the default provider to deepseek
    provider = "deepseek",
    -- Vendor-specific configurations
    vendors = {
      deepseek = {
        -- Inherit settings from openai configuration
        __inherited_from = "openai",
        -- Environment variable name for API key
        api_key_name = "DEEPSEEK_API_KEY",
        -- API endpoint URL
        endpoint = "https://api.deepseek.com",
        -- Model to use
        model = "deepseek-coder",
        -- Proxy settings (empty by default)
        proxy = "",
      },
    },
  },
  -- Build command for Linux/MacOS
  build = "make",
  -- Optional build command for Windows
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
  -- Plugin dependencies
  dependencies = {
    -- Required dependencies
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- Optional dependencies
    "echasnovski/mini.pick",         -- File selector provider using mini.pick
    "nvim-telescope/telescope.nvim", -- File selector provider using telescope
    "hrsh7th/nvim-cmp",              -- Autocompletion support
    "ibhagwan/fzf-lua",              -- File selector provider using fzf
    "nvim-tree/nvim-web-devicons",   -- Icons support (alternative: mini.icons)
    "zbirenbaum/copilot.lua",        -- Copilot provider support
    -- Image pasting support
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true, -- Required for Windows users
        },
      },
    },
    -- Markdown rendering support
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante", },
      },
      ft = { "markdown", "Avante", },
    },
  },
}
