return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    keys = {
      { "<leader>e", false },
      { "<leader>E", "<CMD>Neotree toggle reveal<CR>", desc = "Neotree" },
    },
  },
  { "rafamadriz/friendly-snippets", enabled = false },
}
