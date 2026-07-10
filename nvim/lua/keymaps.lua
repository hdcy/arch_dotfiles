-- 快捷键
local map = vim.keymap.set

-- leader 键设为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 取消高亮
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

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

-- 跳转行首行尾
map({ "n", "v" }, "H", "^", { desc = "行首" })
map({ "n", "v" }, "L", "g_", { desc = "行尾（不含换行）" })

-- 保存 / 退出
map({ "n", "v" }, "<leader>w", "<cmd>w<CR>", { desc = "保存" })
map({ "n", "v" }, "<leader>q", "<cmd>q<CR>", { desc = "退出" })

-- 搜索 / 命令行
map("n", "<leader>f", "/", { desc = "搜索" })
map("n", "<leader><leader>", ":", { desc = "命令行" })

-- jj 退出插入模式
map("i", "jj", "<Esc>", { desc = "退出插入模式" })
