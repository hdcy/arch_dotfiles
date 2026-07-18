-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 基础配置（与插件无关）
require("options")
require("keymaps")
require("autocmds")

-- 插件（lua/plugins/ 下所有文件自动导入）
require("lazy").setup(
  { { import = "plugins" } },
  {
    change_detection = {
      enabled = true,
      notify = false,
    },
  }
)
