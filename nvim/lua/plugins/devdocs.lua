return {
  "GeorgiChochev/nvim-devdocs",
  branch = "master",
  cmd = {
    "DevdocsFetch",
    "DevdocsInstall",
    "DevdocsUninstall",
    "DevdocsOpen",
    "DevdocsOpenFloat",
    "DevdocsOpenCurrent",
    "DevdocsOpenCurrentFloat",
    "DevdocsToggle",
    "DevdocsUpdate",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = { { "<leader>fD", ":DevdocsOpen<cr>", desc = "DevDocs" } },
  opts = {
    mappings = {
      open_in_browser = "gb",
    },
  },
}
