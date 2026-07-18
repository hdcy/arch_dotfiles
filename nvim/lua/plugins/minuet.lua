-- DeepSeek FIM 代码补全
-- 需要先设置环境变量：export DEEPSEEK_API_KEY="你的 DeepSeek API Key"
return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    config = function()
      require("minuet").setup({
        provider = "openai_fim_compatible",

        -- 速度优先：降低节流/防抖，减少上下文，只取一条建议
        throttle = 800,
        debounce = 300,
        request_timeout = 10,
        context_window = 8000,
        n_completions = 1,

        -- 虚拟文本前端：像 Copilot 一样出灰色建议，不依赖 nvim-cmp
        virtualtext = {
          auto_trigger_ft = { "lua", "python", "javascript", "typescript", "rust", "go", "c", "cpp", "sh", "bash" },
          keymap = {
            accept = "<A-a>",        -- 接受整条建议
            accept_line = "<A-l>",    -- 只接受当前行
            accept_n_lines = "<A-z>", -- 接受 N 行（会提示输入数字）
            next = "<A-]>",           -- 下一条建议
            prev = "<A-[>",           -- 上一条建议
            dismiss = "<A-e>",        -- 关闭建议
          },
        },

        provider_options = {
          openai_fim_compatible = {
            name = "Deepseek",
            api_key = "DEEPSEEK_API_KEY",
            end_point = "https://api.deepseek.com/beta/completions",
            model = "deepseek-v4-flash",
            stream = true,

            -- DeepSeek FIM 只想要原始代码，不要 minuet 默认加的语言/缩进注释
            template = {
              prompt = function(context_before_cursor, _, _)
                return context_before_cursor
              end,
              suffix = function(_, context_after_cursor, _)
                return context_after_cursor
              end,
            },

            optional = {
              max_tokens = 128,
              top_p = 0.9,
            },
          },
        },
      })
    end,
  },
}
