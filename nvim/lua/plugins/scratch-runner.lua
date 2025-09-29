return {
  {
    "DestopLine/scratch-runner.nvim",
    dependencies = "folke/snacks.nvim",
    event = "VeryLazy",
    ---@module "scratch-runner"
    ---@type scratch-runner.Config
    opts = {
      sources = {
        javascript = { { "deno", extension = "js" } },
        typescriptreact = {
          function(file_path, bin_path)
            return { "deno", file_path, "--ext=tsx", bin_path }
          end,
          extension = "tsx",
        },
        typescript = {
          function(file_path, bin_path)
            return { "deno", file_path, "--ext=ts", bin_path }
          end,
          extension = "ts",
        },
      },
    },
  },
}
