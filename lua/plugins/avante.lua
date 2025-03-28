return {
  -- Plugin specification for avante.nvim
  "yetone/avante.nvim",
  -- Load the plugin very lazily
  event = "VeryLazy",
  -- Version specification (never use "*")
  version = false,
  -- Configuration options for the plugin
  opts = {
    -- provider = "claude",
    -- claude = {
    --   api_key_name = "ANTHROPIC_API_KEY",
    -- }
    -- Set the default provider to deepseek
    provider = "aaaclaude",
    -- Vendor-specific configurations
    vendors = {
      ---@type AvanteProvider
      ["aaaclaude"] = {
        endpoint = "https://api.gptsapi.net/v1/chat/completions",
        model = "claude-3-7-sonnet-20250219",
        api_key_name = "ANTHROPIC_API_KEY",

        parse_curl_args = function(opts, code_opts)
          -- 构建请求头
          local headers = {
            "Content-Type: application/json",
            "anthropic-version: 2023-06-01",
            "x-api-key: " .. vim.env[opts.api_key_name],
          }

          -- 构建多模态消息内容
          local content = {
            {
              type = "text",
              text = opts.question .. "\n\n" 
                .. "代码语言: " .. opts.code_lang .. "\n"
                .. "完整代码:\n" .. opts.code_content
            }
          }

          -- 添加选中代码片段（如果有）
          if code_opts.selected_code_content then
            table.insert(content, {
              type = "text",
              text = "\n选中代码片段:\n" .. code_opts.selected_code_content
            })
          end

          -- 构建请求体
          local body = vim.json.encode({
            model = opts.model,
            messages = {{
              role = "user",
              content = content
            }},
            max_tokens = 4096,
            stream = true
          })

          return {
            method = "POST",
            headers = headers,
            body = body
          }
        end,

        parse_response = function(data_stream, event_state, opts)
          -- 处理 Claude 的 SSE 响应流
          for line in data_stream:gmatch("[^\r\n]+") do
            if line:find("^event: ") then
              event_state = line:sub(8) -- 获取事件类型
            elseif line:find("^data: ") then
              local json_str = line:sub(6)
              local ok, data = pcall(vim.json.decode, json_str)
              if not ok then
                opts.on_complete("JSON 解析错误")
                return
              end

              -- 处理不同事件类型
              if event_state == "message_start" then
                opts.on_start() -- 开始处理
              elseif event_state == "content_block_delta" then
                if data.delta and data.delta.text then
                  opts.on_chunk(data.delta.text) -- 实时输出文本
                end
              elseif event_state == "message_stop" then
                opts.on_complete() -- 完成处理
              elseif event_state == "error" then
                opts.on_complete("API 错误: " .. (data.error.message or "未知错误"))
              end
            end
          end
        end,

        -- 高级错误处理
        on_error = function(result)
          if result.status == 429 then
            return "请求过于频繁，请稍后再试"
          end
          local ok, err_data = pcall(vim.json.decode, result.body)
          if ok and err_data.error then
            return string.format("API 错误 (%d): %s", result.status, err_data.error.message)
          end
          return "未知错误: " .. result.body
        end
      }
    },
    -- -- Set the default provider to deepseek
    -- provider = "deepseek",
    -- -- Vendor-specific configurations
    -- vendors = {
    --   deepseek = {
    --     -- Inherit settings from openai configuration
    --     __inherited_from = "openai",
    --     -- Environment variable name for API key
    --     api_key_name = "DEEPSEEK_API_KEY",
    --     -- API endpoint URL
    --     endpoint = "https://api.deepseek.com",
    --     -- Model to use
    --     model = "deepseek-coder",
    --     -- Proxy settings (empty by default)
    --     proxy = "",
    --   },
    -- },
    -- provider = "ollama",
    -- ollama = {
    --   model = "qwq:latest",
    -- },
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
