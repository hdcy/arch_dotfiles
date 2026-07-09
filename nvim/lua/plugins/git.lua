-- Git
return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        -- 行内 blame（可选）
        current_line_blame = true,
      })

      -- 快捷键
      vim.keymap.set("n", "]h", function()
        if vim.wo.diff then return "]h" end
        vim.schedule(function() require("gitsigns").next_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "下一处改动" })

      vim.keymap.set("n", "[h", function()
        if vim.wo.diff then return "[h" end
        vim.schedule(function() require("gitsigns").prev_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "上一处改动" })
    end,
  },
}
