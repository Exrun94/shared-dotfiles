local M = {}

function M.is_mac()
  return vim.loop.os_uname().sysname == "Darwin"
end

function M.is_linux()
  return vim.loop.os_uname().sysname == "Linux"
end

return M
