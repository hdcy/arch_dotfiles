local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    kotlin = { "ktlint" },
    xml = { "xmllint" },
  },

  formatters = {
    xmllint = {
      stdin = true,
      args = { "--format", "-" },
    },
  },
}

return options
