-- Helper functions for code review command
local MAX_FILE_SIZE = 1024 * 1024 -- 1MB limit for file display

-- Process git command and return its output
local function process_git_command(command)
  local handle = io.popen(command)
  if not handle then
    return ""
  end
  local result = handle:read("*a")
  handle:close()
  return result
end

-- Process git command that returns a list of files
local function process_file_list_command(command)
  local result = {}
  local output = process_git_command(command)
  for file in output:gmatch("([^\n]+)") do
    if #file > 0 then
      table.insert(result, file)
    end
  end
  return result
end

-- Check if a file exceeds the size limit
local function check_file_size(file_path)
  local stats = vim.loop.fs_stat(file_path)
  return stats and stats.size <= MAX_FILE_SIZE
end

-- Generate the git review content for CodeCompanion
local function generate_git_review()
  -- Check if we're in a git repository
  local is_git_repo = process_git_command("git rev-parse --is-inside-work-tree 2>/dev/null")
  if is_git_repo ~= "true\n" then
    vim.notify("Not in a git repository", vim.log.levels.WARN, { title = "CodeCompanion" })
    return nil
  end

  -- Get git changes
  local staged = process_git_command("git diff --no-ext-diff --staged")
  local unstaged = process_git_command("git diff")
  local new_staged_files = process_file_list_command("git diff --staged --name-status | grep '^A' | cut -f2")
  local untracked_files = process_file_list_command("git ls-files --others --exclude-standard")

  -- Initialize content
  local content = [[cmd_runner
- Task:
  - Analyze the provided git diff thoroughly
  - Identify potential bugs, security issues, and performance concerns
  - Suggest code quality improvements and best practices
  - Highlight any critical issues that should be addressed before committing
  - Organize your analysis by file and change type
  - Note both positive aspects and areas for improvement
  - Highlight using code blocks and comments when necessary

### Git Diff Analysis

]]
  local has_changes = false

  -- Add staged changes
  if #staged > 0 then
    content = content
      .. "== Staged Changes Start(`git diff --no-ext-diff --staged`) ==\n```diff\n"
      .. staged
      .. "\n```\n== Staged Changes End(`git diff --no-ext-diff --staged`) ==\n\n"
    has_changes = true
  end

  -- Add new staged files content
  for _, file in ipairs(new_staged_files) do
    -- Sanitize file path for shell command
    local sanitized_file = file:gsub('([%s%&%$%|%;%<%>%`%!"%~%*%?%[%]%{%}%\\])', "\\%1")
    local file_content = process_git_command(string.format("git show :%s", sanitized_file))

    if #file_content > 0 then
      content = content .. string.format("== New Staged File: %s ==\n```\n", file) .. file_content .. "\n```\n\n"
      has_changes = true
    end
  end

  -- Add unstaged changes
  if #unstaged > 0 then
    content = content
      .. "== Unstaged Changes Start(`git diff`) ==\n```diff\n"
      .. unstaged
      .. "\n```\n== Unstaged Changes End(`git diff`) ==\n\n"
    has_changes = true
  end

  -- Add untracked files content
  for _, file in ipairs(untracked_files) do
    if check_file_size(file) then
      local handle = io.open(file, "r")
      if handle ~= nil then
        local file_content = handle:read("*a")
        handle:close()
        if #file_content > 0 then
          content = content .. string.format("== Untracked File: %s ==\n```\n", file) .. file_content .. "\n```\n\n"
          has_changes = true
        end
      end
    else
      content = content .. string.format("== Untracked File: %s (too large to display) ==\n\n", file)
      has_changes = true
    end
  end

  if not has_changes then
    return nil
  end

  return content
end

---@param chat CodeCompanion.Chat
local function callback(chat)
  local content = generate_git_review()
  if content == nil then
    vim.notify("No git changes available to review", vim.log.levels.INFO, { title = "CodeCompanion" })
    return
  end
  chat:add_buf_message({
    role = "user",
    content = content,
  })
end

return {
  description = "Analyze git changes and provide detailed code review",
  callback = callback,
  opts = {
    contains_code = true,
  },
}
