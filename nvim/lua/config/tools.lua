return {
  {
    name = "JQ Pretty",
    execute = function()
      vim.cmd("%!jq '.'")
    end,
  },
  {
    name = "JQ Trim whitespace",
    execute = function()
      vim.cmd("%!jq -c '.'")
    end,
  },
  {
    name = "Color Picker (Shades)",
    execute = function()
      require("minty.shades").open({ border = true })
    end,
  },
  {
    name = "Color Picker (Hue)",
    execute = function()
      require("minty.huefy").open({ border = true })
    end,
  },
  {
    name = "Disable underline warn curl",
    execute = function()
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = false })
    end,
  },
  {
    name = "Open cwd in File Manager",
    execute = function()
      vim.cmd([[!xdg-open %:p:h]])
    end,
  },
  {
    name = "Copy File Path",
    execute = function()
      local path = vim.fn.expand("%:p")
      vim.fn.setreg("+", path)
      vim.notify(path, vim.log.levels.INFO)
    end,
  },
  {
    name = "Disable Mini Pairs",
    execute = function()
      vim.b.minipairs_disable = true
      vim.notify("Mini Pairs disabled for current buffer", vim.log.levels.INFO)
    end,
  },
  {
    name = "Enable Mini Pairs",
    execute = function()
      vim.b.minipairs_disable = false
      vim.notify("Mini Pairs enabled for current buffer", vim.log.levels.INFO)
    end,
  },
  {
    name = "Insert Code Block",
    execute = function()
      vim.ui.input({ prompt = "Enter language: " }, function(language)
        if language then
          local pos = vim.api.nvim_win_get_cursor(0)
          local line = pos[1] - 1
          vim.api.nvim_buf_set_lines(0, line, line, false, {
            "```" .. language,
            "",
            "```",
          })
          -- Move cursor to the empty line between the code block
          vim.api.nvim_win_set_cursor(0, { line + 2, 0 })
          vim.notify(language .. " code block inserted", vim.log.levels.INFO)
        end
      end)
    end,
  },
  {
    name = "Add Snippet",
    execute = function()
      require("scissors").addNewSnippet()
    end,
  },
  {
    name = "Edit Snippet",
    execute = function()
      require("scissors").editSnippet()
    end,
  },
  {
    name = "[GIT] Reset current file from specific branch",
    execute = function()
      -- Get current file path relative to git root
      local current_file = vim.fn.expand("%:p")
      local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("%s+$", "")

      if vim.v.shell_error ~= 0 then
        vim.notify("Not in a git repository", "error")
        return
      end

      local relative_path = current_file:gsub("^" .. vim.pesc(git_root) .. "/", "")

      -- Get remote branches
      local branches_raw = vim.fn.system("git branch -r"):gsub("%s+$", "")

      if vim.v.shell_error ~= 0 then
        vim.notify("Failed to get remote branches", "error")
        return
      end

      -- Parse branches
      local branches = {}
      for branch in branches_raw:gmatch("[^\r\n]+") do
        -- Clean up branch name (remove leading spaces and "origin/")
        branch = branch:gsub("^%s*", "")
        table.insert(branches, { text = branch })
      end

      if #branches == 0 then
        vim.notify("No remote branches found", "warn")
        return
      end

      Snacks.picker.pick({
        source = "git-branches",
        items = branches,
        format = "text",
        on_show = function()
          -- picker opening after a picker doesnt enter in insert mode, this isnt working either but it was worth the shot..
          vim.cmd.startinsert()
        end,
        layout = {
          preset = "vscode",
        },
        confirm = function(picker, item)
          picker:close()

          -- Extract branch name
          local branch = item.text

          -- Show a notification that we're resetting the file
          vim.notify("Resetting " .. relative_path .. " to " .. branch .. " state...", "info")

          -- Reset the current file to the selected branch state
          local cmd = string.format("git show %s:%s > %s", branch, relative_path, current_file)
          local result = vim.fn.system(cmd)

          if vim.v.shell_error ~= 0 then
            vim.notify("Failed to reset file: " .. result, "error")
            return
          end

          -- Reload the buffer to show changes
          vim.cmd("e!")
          vim.notify("File reset to " .. branch .. " state", "info")
        end,
      })
    end,
  },
  {
    name = "Open Current File in Browser",
    execute = function()
      local file = vim.fn.expand("%:p")
      local escaped_file = vim.fn.shellescape(file)

      vim.fn.jobstart("xdg-open " .. escaped_file, {
        detach = true,
        on_exit = function(_, exit_code)
          if exit_code ~= 0 then
            vim.notify("Failed to open file in browser", vim.log.levels.ERROR)
          end
        end,
      })
    end,
  },
}
