-- 编辑器增强
return {
  -- 快速跳转（按 s 触发，输入目标字符，两键直达）
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup({
        labels = "asdfghjklqwertyuiopzxcvbnm", -- 单手键位
        modes = {
          search = { enabled = true }, -- / 搜索时高亮跳转
          char = { enabled = false },  -- 关闭 f/t 增强，用原生的
        },
      })
      -- s 触发跳转，S 触发行内跳转
      vim.keymap.set({ "n", "x", "o" }, "f", function()
        require("flash").jump()
      end, { desc = "Flash 跳转" })
      vim.keymap.set({ "n", "x", "o" }, "F", function()
        require("flash").treesitter()
      end, { desc = "Flash 语法树跳转" })
      -- 远程跳转（大范围）
      vim.keymap.set("n", "r", function()
        require("flash").remote()
      end, { desc = "Flash 远程跳转" })
      vim.keymap.set({ "o", "x" }, "r", function()
        require("flash").remote()
      end, { desc = "Flash 远程跳转" })
    end,
  },
}
