return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          vim.api.nvim_buf_set_keymap(buf,
            "n",
            "<leader>gf",
            "<cmd>lua vim.lsp.buf.format()<cr><cmd>write<cr>",
            { noremap = true, silent = true, desc = "格式化代码", }
          )
        end,
      })
      local lspconfig = require("lspconfig")
      lspconfig["lua_ls"].setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", },
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_size = "2",
                tab_width = "2",
                quote_style = "double",
                continuation_indent = "2",
                max_line_length = "80",
                table_separator_style = "comma",
                trailing_table_separator = "always",
                detect_end_of_line = "true",
                space_before_function_call_single_arg = "none",
              },
            },
          },
        },
      })
      lspconfig["pyright"].setup({})
      lspconfig["nil_ls"].setup({
        settings = {
          ["nil"] = {
            testSetting = 42,
            formatting = {
              command = { "nixfmt", },
            },
          },
        },
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons",     -- optional
    },
    opts = {
      lightbulb = {
        enable = true,
        sign = false,
      },
      outline = {
        close_after_jump = true,
        layout = "float",
        left_width = 0.5,
      },
    },
    keys = {
      { "<leader>gc", "<cmd>Lspsaga code_action<cr>",     desc = "code_action", },
      { "<leader>gk", "<cmd>Lspsaga peek_definition<cr>", desc = "peek_definition", },
      { "<leader>gr", "<cmd>Lspsaga rename<cr>",          desc = "rename", },
      { "<leader>gl", "<cmd>Lspsaga outline<cr>",         desc = "outline", },
      { "K",          "<cmd>Lspsaga hover_doc<cr>",       desc = "hover_doc", },
    },
  },
}
