return {
  "nvzone/floaterm",
  dependencies = "nvzone/volt",
  cmd = "FloatermToggle",
  keys = {
    { mode = { "n", "i", "x", "t" }, "<F2>", "<cmd>FloatermToggle<cr>" },
  },
  opts = {
    border = true,
    size = { h = 70, w = 80 },
    mappings = {
      term = function(buf)
        vim.keymap.set({ "t" }, "<Del>", function()
          require("floaterm.api").cycle_term_bufs("prev")
        end, { buffer = buf })
      end,
    },
    -- Default sets of terminals you'd like to open
    terminals = {
      { name = "Terminal" },
      -- cmd can be function too
      { name = "ClaudeCode", cmd = "claude" },
      -- More terminals
    },
  },
}
