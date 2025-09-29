local usercmd = vim.api.nvim_create_user_command

usercmd("TypeGenerator", function()
  vim.ui.input({ prompt = "Enter curl URL: " }, function(link)
    if link then
      local output = vim.fn.system("curl -s" .. link .. "| jq '.data' | quicktype --just-types -l ts")
      local lines = vim.split(output, "\n")
      vim.api.nvim_put(lines, "l", true, true)
    end
  end)
end, {})

usercmd("UpdateAll", function()
  require("lazy").load({ plugins = { "mason.nvim", "nvim-treesitter" } })
  vim.cmd("MasonUpdate")
  vim.cmd("TSUpdate")
  vim.cmd("Lazy sync")
end, { desc = "Batch update" })

usercmd("AddSurroundingTag", function()
  vim.schedule(function()
    -- Execute gsat in visual mode
    vim.cmd("normal gsat")
  end)
end, { desc = "Adds surround HTML tag" })

usercmd("ToggleCheckBox", function()
  local checked_character = "x"

  local checked_checkbox = "%[" .. checked_character .. "%]"
  local unchecked_checkbox = "%[ %]"

  local line_contains_unchecked = function(line)
    return line:find(unchecked_checkbox)
  end

  local line_contains_checked = function(line)
    return line:find(checked_checkbox)
  end

  local line_with_checkbox = function(line)
    -- return not line_contains_a_checked_checkbox(line) and not line_contains_an_unchecked_checkbox(line)
    return line:find("^%s*- " .. checked_checkbox)
      or line:find("^%s*- " .. unchecked_checkbox)
      or line:find("^%s*%d%. " .. checked_checkbox)
      or line:find("^%s*%d%. " .. unchecked_checkbox)
  end

  local checkbox = {
    check = function(line)
      return line:gsub(unchecked_checkbox, checked_checkbox, 1)
    end,

    uncheck = function(line)
      return line:gsub(checked_checkbox, unchecked_checkbox, 1)
    end,

    make_checkbox = function(line)
      if not line:match("^%s*-%s.*$") and not line:match("^%s*%d%s.*$") then
        -- "xxx" -> "- [ ] xxx"
        return line:gsub("(%S+)", "- [ ] %1", 1)
      else
        -- "- xxx" -> "- [ ] xxx", "3. xxx" -> "3. [ ] xxx"
        return line:gsub("(%s*- )(.*)", "%1[ ] %2", 1):gsub("(%s*%d%. )(.*)", "%1[ ] %2", 1)
      end
    end,
  }
  local bufnr = vim.api.nvim_buf_get_number(0)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local start_line = cursor[1] - 1
  local current_line = vim.api.nvim_buf_get_lines(bufnr, start_line, start_line + 1, false)[1] or ""

  -- If the line contains a checked checkbox then uncheck it.
  -- Otherwise, if it contains an unchecked checkbox, check it.
  local new_line = ""

  if not line_with_checkbox(current_line) then
    new_line = checkbox.make_checkbox(current_line)
  elseif line_contains_unchecked(current_line) then
    new_line = checkbox.check(current_line)
  elseif line_contains_checked(current_line) then
    new_line = checkbox.uncheck(current_line)
  end

  vim.api.nvim_buf_set_lines(bufnr, start_line, start_line + 1, false, { new_line })
  vim.api.nvim_win_set_cursor(0, cursor)
end, { desc = "Toggle Markdown Checkboxes" })
