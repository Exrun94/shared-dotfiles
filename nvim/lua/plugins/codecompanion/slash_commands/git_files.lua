return {
  description = "List git files",
  ---@param chat CodeCompanion.Chat
  callback = function(chat)
    local handle = io.popen("git ls-files")
    if handle ~= nil then
      local result = handle:read("*a")
      handle:close()
      chat:add_reference({ role = "user", content = result }, "git", "<git_files>")
    else
      return vim.notify("No git files available", vim.log.levels.INFO, { title = "CodeCompanion" })
    end
  end,
  opts = {
    contains_code = false,
  },
}
