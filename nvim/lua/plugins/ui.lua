-- 外观
return {
  -- 主题
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- 文件树
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    keys = {
      { "<leader>e", desc = "文件树" },
    },
    config = function()
      require("nvim-tree").setup({
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          -- 保持默认快捷键
          api.config.mappings.default_on_attach(bufnr)
          -- 宽度调整（仅在树窗口）
          -- 先用逗号句号试试，不行改成别的键
          vim.keymap.set("n", ",", function()
            vim.api.nvim_win_set_width(0, math.max(15, vim.api.nvim_win_get_width(0) - 5))
          end, { buffer = bufnr, desc = "缩窄文件树" })
          vim.keymap.set("n", ".", function()
            vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + 5)
          end, { buffer = bufnr, desc = "加宽文件树" })
        end,
      })

      -- 启动时自动打开（有文件则聚焦文件，无文件则聚焦树）
      vim.defer_fn(function()
        local api = require("nvim-tree.api")
        api.tree.open()
        if vim.fn.argc() > 0 then
          vim.cmd("wincmd p")
        end
      end, 0)

      -- 智能开关：关 → 开 / 开未聚焦 → 聚焦 / 已聚焦 → 回到上一个文件
      vim.keymap.set("n", "<leader>e", function()
        local api = require("nvim-tree.api")
        if api.tree.is_tree_buf() then
          vim.cmd("wincmd p")
        elseif api.tree.is_visible() then
          api.tree.focus()
        else
          api.tree.open()
        end
      end, { desc = "文件树" })
    end,
  },
}
