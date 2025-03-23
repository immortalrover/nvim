-- nvim-cmp plugin configuration
return {
  "hrsh7th/nvim-cmp",
  lazy = true,
  event = { "InsertEnter", "CmdlineEnter", },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind-nvim",
  },
  config = function()
    -- Load required modules
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")
    local cmp = require("cmp")
    -- Setup nvim-cmp
    cmp.setup({
      -- Snippet configuration
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      -- Key mappings
      mapping = cmp.mapping.preset.insert({
        -- Scroll documentation up
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c", }),
        -- Scroll documentation down
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c", }),
        -- Confirm selection or expand snippet
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),
        -- Select next item or jump in snippet
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s", }),
        -- Select previous item or jump back in snippet
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s", }),
        -- Abort completion
        ["<C-e>"] = cmp.mapping.abort(),
      }),
      -- Completion sources
      sources = cmp.config.sources({
        { name = "nvim_lsp", },
        { name = "vsnip", },
        { name = "buffer", },
        { name = "path", },
      }),
      -- Formatting configuration using lspkind
      formatting = {
        format = lspkind.cmp_format({
          with_text = true,
          maxwidth = 50,
          before = function(entry, vim_item)
            -- Add source name to menu
            vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
            return vim_item
          end,
        }),
      },
    })
    -- Load vscode-style snippets
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
