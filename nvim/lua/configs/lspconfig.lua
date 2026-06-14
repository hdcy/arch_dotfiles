require("nvchad.configs.lspconfig").defaults()

-- Define Kotlin LSP config
vim.lsp.config.kotlin_language_server = {
  cmd = { "/home/x68/.local/share/nvim/mason/bin/kotlin-language-server" },
  cmd_env = {
    JAVA_HOME = "/usr/lib/jvm/java-21-openjdk",
  },
  root_markers = { "settings.gradle.kts", "build.gradle.kts" },
  filetypes = { "kotlin" },
}

-- Auto-attach when opening any Kotlin file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "kotlin",
  callback = function(args)
    vim.lsp.start(vim.lsp.config.kotlin_language_server, { bufnr = args.buf })
  end,
})

-- Other language servers (standard ones can use vim.lsp.enable)
local servers = { "html", "cssls" }
vim.lsp.enable(servers)
