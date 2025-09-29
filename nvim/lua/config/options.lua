-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}
vim.g.autoformat = true
vim.opt.relativenumber = true
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.spell = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "context:12",
  "algorithm:histogram",
  "linematch:200",
  "indent-heuristic",
  "iwhite", -- I toggle this one, it doesn't fit all cases.
}

vim.g.lazyvim_blink_main = true
vim.g.lazyvim_picker = "snacks"
