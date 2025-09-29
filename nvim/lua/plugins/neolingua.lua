return {
  enabled = require("utils.os").is_linux(),
  dir = "~/dev/nvim/neolingua.nvim",
  dev = true,
  cmd = {
    "NeoLinguaUpdate",
    "NeoLinguaFindValues",
    "NeoLinguaFindKeys",
    "NeoLinguaCreate",
    "NeoLinguaPublish",
    "NeoLinguaRead",
  },
  keys = {
    { "<leader>lk", "<cmd>NeoLinguaFindKeys<CR>", desc = "[L]ingua [K]eys" },
    { "<leader>lv", "<cmd>NeoLinguaFindValues<CR>", desc = "[L]ingua [V]alues" },
    { "<leader>lu", "<cmd>NeoLinguaUpdate<CR>", desc = "[L]ingua [U]pdate" },
    { "<leader>lr", "<cmd>NeoLinguaRead<CR>", desc = "[L]ingua [R]ead" },
    { "<leader>lc", "<cmd>NeoLinguaCreate<CR>", desc = "[L]ingua [C]reate" },
    { "<leader>lp", "<cmd>NeoLinguaPublish<CR>", desc = "[L]ingua [P]ublish" },
  },
  opts = {
    enable_lingua = true,
    enable_cmp = true,
    repositories = {
      {
        name = "EmailMarketing",
        repo = "git@github.com:SiteGround/email-tools.git",
        push = "emailmarketing",
        pull = "em",
      },
      {
        name = "UserArea",
        repo = "git@gitlab.siteground.com:developers/sg-userarea-spa.git",
        push = "sgua",
        pull = "sgua",
      },
      {
        name = "SiteTools",
        repo = "git@gitlab.siteground.com:developers/spanel-spa.git",
        push = "spanel",
        pull = "spanel",
      },
    },
    keymaps = {
      update = "<leader>lu",
      create = "<leader>lc",
      publish = "<leader>lp",
      find_values = "<leader>lv",
      find_keys = "<leaader>lk",
      copy_saved = "<leader>ls",
    },
    snacks_opts = {
      preset = "ivy", -- vscode | ivy | default | telescope | select | vertical | dropdown
    },
    log_level = "info",
  },
}
