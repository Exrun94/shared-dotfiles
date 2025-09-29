return {
  "chrisgrieser/nvim-recorder",
  dependencies = "rcarriga/nvim-notify",
  keys = {
    -- these must match the keys in the mapping config below
    { "<F5>", desc = " Start Recording" },
    { "<F6>", desc = " Play Recording" },
  },
  opts = {
    mapping = {
      startStopRecording = "<F5>",
      playMacro = "<F6>",
    },
  },
}
