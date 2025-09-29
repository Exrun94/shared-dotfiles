-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufEnter", "FileType" }, {
  desc = "Prevent auto-comment on new line.",
  pattern = "*",
  group = augroup("NoNewLineComment", { clear = true }),
  command = [[
    setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  ]],
})

autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      local set = vim.opt_local
      set.number = false -- Don't show numbers
      set.relativenumber = false -- Don't show relativenumbers
      set.scrolloff = 0 -- Don't scroll when at the top or bottom
      set.spell = false -- Disable spell checking
      vim.opt.filetype = "terminal"
      vim.opt_local.modifiable = true
      vim.opt_local.winhighlight = "Normal:MsgSeparator,FloatBorder:MsgSeparator"

      vim.cmd.startinsert() -- Start in insert mode
    end
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".zshrc", ".zprofile", ".zshenv", ".zlogin", ".zlogout" },
  callback = function()
    vim.bo.filetype = "zsh"
  end,
})

-- autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
--   end,
-- })
