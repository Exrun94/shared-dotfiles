return {
  "williamboman/mason.nvim",
  opts_extend = { "ensure_installed" },

  opts = {
    ensure_installed = {
      "templ",
      -- "htmx-lsp",
      -- "tailwindcss-language-server",
      "html-lsp",
      "css-lsp",
      -- "efm",
      -- "gopls",
      "bash-language-server",
      "html-lsp",
      "jsonlint",
      "json-lsp",
      "prettier",
      "shellcheck",
      "yaml-language-server",
      "yamllint",
      "yamlfix",
    },
  },
}
