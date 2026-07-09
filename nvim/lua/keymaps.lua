-- 快捷键
local map = vim.keymap.set

-- leader 键设为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 取消高亮
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 页面滚动（记录到跳转历史）
map("n", "<C-d>", "m'<C-d>", { desc = "下翻半页" })
map("n", "<C-u>", "m'<C-u>", { desc = "上翻半页" })
map("n", "<C-f>", "m'<C-f>", { desc = "下翻整页" })
map("n", "<C-b>", "m'<C-b>", { desc = "上翻整页" })

-- 窗口导航
map("n", "<C-h>", "<C-w>h", { desc = "切到左窗口" })
map("n", "<C-j>", "<C-w>j", { desc = "切到下窗口" })
map("n", "<C-k>", "<C-w>k", { desc = "切到上窗口" })
map("n", "<C-l>", "<C-w>l", { desc = "切到右窗口" })

-- 缩进保持选择
map("v", "<", "<gv", { desc = "减少缩进" })
map("v", ">", ">gv", { desc = "增加缩进" })

-- 上下移动行
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "下移行" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "上移行" })

-- 分屏
map("n", "<leader>sv", "<C-w>v", { desc = "垂直分屏" })
map("n", "<leader>sh", "<C-w>s", { desc = "水平分屏" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "关闭分屏" })

-- Tab
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "新标签" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "关闭标签" })
map("n", "<tab>", "<cmd>tabnext<CR>", { desc = "下一标签" })
map("n", "<S-tab>", "<cmd>tabprevious<CR>", { desc = "上一标签" })

-- 跳转行首行尾
map({ "n", "v" }, "H", "^", { desc = "行首" })
map({ "n", "v" }, "L", "g_", { desc = "行尾（不含换行）" })

-- 保存 / 退出
map({ "n", "v" }, "<leader>w", "<cmd>w<CR>", { desc = "保存" })
map({ "n", "v" }, "<leader>q", "<cmd>q<CR>", { desc = "退出" })

-- 搜索 / 命令行
map("n", "<leader>f", "/", { desc = "搜索" })
map("n", "<leader><leader>", ":", { desc = "命令行" })

-- 跳转历史（自动跳过文件树/终端窗口）
local function jump_smart(dir)
  return function()
    local keycode = dir == 1 and "<C-i>" or "<C-o>"
    -- 转成原始控制字符，用 normal! 保证不受用户映射影响
    local raw = vim.api.nvim_replace_termcodes(keycode, true, false, true)
    for _ = 1, 50 do
      vim.cmd("silent! normal! " .. raw)
      local ft = vim.bo.filetype
      if ft ~= "NvimTree" and ft ~= "toggleterm" and vim.bo.buftype ~= "terminal" then
        break
      end
    end
  end
end
map("n", "<A-j>", jump_smart(1), { desc = "下一跳转位置" })
map("n", "<A-k>", jump_smart(-1), { desc = "上一跳转位置" })

-- jj 退出插入模式
map("i", "jj", "<Esc>", { desc = "退出插入模式" })
