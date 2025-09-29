return {
  "akinsho/bufferline.nvim",
  keys = {
    {
      "H",
      function()
        require("utils.beepboop").play_audio("teleport")
        vim.cmd("BufferLineCyclePrev")
      end,
    },
    {
      "L",
      function()
        require("utils.beepboop").play_audio("teleport")
        vim.cmd("BufferLineCycleNext")
      end,
    },
    {
      "<leader>bm",
      function()
        Snacks.input.input({ prompt = "Move Tab <Position>", icon = " " }, function(value)
          require("utils.beepboop").play_audio("belt")
          if value then
            require("bufferline").move_to(tonumber(value))
          end
        end)
      end,
    },
    {
      "<leader>1",
      function()
        require("utils.beepboop").play_audio("potiondrink")
        vim.cmd("BufferLineGoToBuffer 1")
      end,
    },
    {
      "<leader>2",
      function()
        require("utils.beepboop").play_audio("potiondrink")
        vim.cmd("BufferLineGoToBuffer 2")
      end,
    },
    {
      "<leader>3",
      function()
        require("utils.beepboop").play_audio("potiondrink")
        vim.cmd("BufferLineGoToBuffer 3")
      end,
    },
    {
      "<leader>4",
      function()
        require("utils.beepboop").play_audio("potiondrink")
        vim.cmd("BufferLineGoToBuffer 4")
      end,
    },
    {
      "<leader>5",
      function()
        require("utils.beepboop").play_audio("potiondrink")
        vim.cmd("BufferLineGoToBuffer 5")
      end,
    },
    {
      "<leader>6",
      function()
        require("utils.beepboop").play_audio("potiondrink")
        vim.cmd("BufferLineGoToBuffer 6")
      end,
    },
    {
      "<leader>7",
      function()
        require("utils.beepboop").play_audio("potiondrink")
        vim.cmd("BufferLineGoToBuffer 7")
      end,
    },
    {
      "<leader>8",
      function()
        require("utils.beepboop").play_audio("potiondrink")
        vim.cmd("BufferLineGoToBuffer 8")
      end,
    },
    {
      "<leader>9",
      function()
        require("utils.beepboop").play_audio("potiondrink")
        vim.cmd("BufferLineGoToBuffer 9")
      end,
    },
  },
  opts = {
    options = {
      style_preset = {
        require("bufferline").style_preset.no_italic,
        require("bufferline").style_preset.no_bold,
      },
      numbers = "ordinal",
      -- separator_style = { "󰄾", "󰄽" },
      separator_style = { "", "" },
      indicator = {
        style = "none",
      },
      -- Explicitly set sorting behavior to prevent automatic reordering
      sort_by = "insert_at_end", -- or try "insert_after_current"
      -- Disable automatic buffer sort persistence that might cause reordering
      persist_buffer_sort = false,
      -- Ensure buffers don't get automatically sorted by other criteria
      enforce_regular_tabs = false,
      -- Debug option: uncomment to see what's happening
      -- diagnostics = false,
    },
  },
}
