return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    -- label = {
    --   min_pattern_length = 0,
    --   rainbow = {
    --     enabled = true,
    --     -- number between 1 and 9
    --     shade = 1,
    --   },
    -- },
    jump = { autojump = true },
    modes = {
      -- char = {
      --   jump_labels = true,
      --   multi_line = false,
      -- },
      search = { enabled = false },
    },
  },
  keys = function()
    return {
      {
        "<CR>",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
          vim.cmd("normal! zz")
        end,
        desc = "Flash",
      },
    }
  end,
}
