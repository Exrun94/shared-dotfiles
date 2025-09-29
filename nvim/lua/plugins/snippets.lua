return {
  lazy = false,
  "chrisgrieser/nvim-scissors",
  dependencies = {
    "folke/snacks.nvim",
  },
  opts = {
    snippetDir = vim.fn.stdpath("config") .. "/snippets",
    jsonFormatter = "jq",
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = vim.fn.stdpath("config") .. "/snippets",
    })
    require("blink.cmp").setup({
      sources = {
        providers = {
          snippets = {
            opts = {
              search_paths = vim.fn.stdpath("config") .. "/snippets",
            },
          },
        },
      },
    })
  end,
}
