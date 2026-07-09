-- 自动命令
local group = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

-- 窗口大小调整后自动平衡
vim.api.nvim_create_autocmd("VimResized", {
  group = group,
  command = "tabdo wincmd =",
})

-- 终端模式下自动进入插入模式
vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  command = "startinsert",
})
