-- LSP：定义跳转 + 诊断 + 悬浮文档
return {
  -- LSP server 包管理器
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = true,
  },
  -- 桥接：mason 安装的 server → lspconfig 自动配置
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      require("mason-lspconfig").setup({
        -- 按需手动安装: :LspInstall <name>
        -- 常用: lua_ls pyright ts_ls rust_analyzer clangd bashls jsonls yamlls html cssls marksman
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({ capabilities = capabilities })
          end,
        },
      })
    end,
  },
  -- 内置 LSP 客户端配置
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf }

          -- 定义跳转
          vim.keymap.set("n", "gd", vim.lsp.buf.definition,      vim.tbl_extend("force", opts, { desc = "跳转到定义" }))
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration,      vim.tbl_extend("force", opts, { desc = "跳转到声明" }))
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition,  vim.tbl_extend("force", opts, { desc = "跳转到类型定义" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation,   vim.tbl_extend("force", opts, { desc = "跳转到实现" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references,       vim.tbl_extend("force", opts, { desc = "查看引用" }))

          -- 悬浮信息
          vim.keymap.set("n", "K",            vim.lsp.buf.hover,           vim.tbl_extend("force", opts, { desc = "悬浮文档" }))
          vim.keymap.set("n", "<leader>K",    vim.lsp.buf.signature_help,  vim.tbl_extend("force", opts, { desc = "签名帮助" }))

          -- 重命名 + 代码操作
          vim.keymap.set("n", "<leader>rn",   vim.lsp.buf.rename,         vim.tbl_extend("force", opts, { desc = "重命名" }))
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "代码操作" }))

          -- 诊断导航
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,  opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next,  opts)
          vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)
        end,
      })
    end,
  },
}
