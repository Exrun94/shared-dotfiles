local Snacks = require("snacks")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    animate = { enabled = true },
    image = { enabled = true },
    picker = {
      enabled = true,
      layout = { layout = { backdrop = false } },
      previewers = {
        diff = {
          builtin = false, -- use Neovim for previewing diffs (true) or use an external tool (false)
          cmd = { "delta" }, -- example to show a diff with delta
        },
      },
    },
    indent = {
      indent = {
        enabled = false,
      },
      chunk = {
        enabled = false,
        char = {
          horizontal = "─",
          vertical = "│",
          corner_top = "╭",
          corner_bottom = "╰",
          arrow = "─",
        },
      },
    },
    scroll = { enabled = false },
    zen = { enabled = false },
    notifier = {
      enabled = true,
      timeout = 3000,
      top_down = false,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = false }, -- Wrap notifications
      },
    },
    scratch = {
      win = {
        width = 200,
        height = 40,
      },
    },
    dashboard = {
      enabled = true,
      autokeys = "1234567890abcdefghijklmnopqrstvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      sections = {
        { section = "header" },
        { section = "keys", padding = 1, gap = 1 },
        { icon = " ", key = "u", desc = "Update", action = ":UpdateAll", padding = 1, gap = 1 },
        {
          icon = " ",
          desc = "Browse Repo",
          padding = 1,
          gap = 1,
          key = "b",
          action = function()
            Snacks.gitbrowse()
          end,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            -- {
            --   icon = " ",
            --   title = "Open PRs",
            --   cmd = 'gh pr list -L 10 2>/dev/null || glab mr list -P 10 -F json | jq -r \'.[] | "\\(.title) (\\(.source_branch)) \\(.created_at | split("T")[0])"\'',
            --   key = "p",
            --   action = function()
            --     vim.fn.jobstart("gh pr list --web", { detach = true })
            --   end,
            --   height = 10,
            -- },
            {
              icon = " ",
              title = "Git Status",
              cmd = "hub --no-pager diff --stat -B -M -C",
              height = 10,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              -- pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
        { section = "startup" },
      },
    },
  },
  keys = {
    {
      "<leader>:",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader><space>",
      function()
        require("utils.beepboop").play_audio("fanaticism")
        Snacks.picker.files({
          hidden = true,
          exclude = {
            "**/LICENSE*",
            "**/.git/*",
            -- "**/*.svg",
            -- "**/*.png",
            -- "**/*.jpg",
            "**/*.ico",
            "**/*.pdf",
            "**/mocks/*",
            "**/i18n/**/*.json",
            "**/.idea/*",
            "**/.vscode/*",
            "**/build/*",
            "**/dist/*",
            "**/yarn.lock",
            "**/package-lock.json",
            "**/CHANGELOG.md",
            "**/cypress/*",
            -- "**/__tests__/*",
          },
        })
      end,
      desc = "Find Files",
    },
    -- find
    {
      "<leader>fb",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.buffers({ layout = { preset = "vscode" } })
      end,
      desc = "Buffers",
    },
    {
      "<leader>fc",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.files({ cwd = vim.fn.stdpath("config"), layout = { preset = "vscode" } })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>fr",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    -- Grep
    {
      "<leader>sb",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      "<leader>sg",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.grep({
          hidden = true,
          exclude = {
            "**/LICENSE*",
            "**/.git/*",
            "**/*.svg",
            "**/*.png",
            "**/*.jpg",
            "**/*.ico",
            "**/*.pdf",
            -- "**/mocks/*",
            "**/i18n/**/*.json",
            "**/.idea/*",
            "**/.vscode/*",
            "**/build/*",
            "**/dist/*",
            "**/yarn.lock",
            "**/package-lock.json",
            "**/CHANGELOG.md",
            "**/cypress/*",
            "node_modules/*",
            -- "**/__tests__/*",
          },
        })
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    -- search
    {
      '<leader>s"',
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>sa",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sc",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sh",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>sH",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.highlights({
          confirm = function(picker, item)
            picker:close()

            vim.fn.setreg("+", item.hl_group)
            vim.notify("hl copied" .. item.hl_group)
          end,
        })
      end,
      desc = "Highlights",
    },
    {
      "<leader>sj",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>sk",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sl",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.loclist()
      end,
      desc = "Location List",
    },
    {
      "<leader>sM",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sm",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>sR",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>sq",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },
    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>.",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>H",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "Q",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gg",
      function()
        require("utils.beepboop").play_audio("levelup")
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
    {

      "<leader>fd",
      desc = "Find Dotfiles",
      function()
        require("utils.beepboop").play_audio("windowopen")
        Snacks.picker.files({
          layout = { preset = "vscode" },
          title = "~Dotfiles~",
          dirs = { "~/dotfiles" },
          exclude = {
            "**/ghostty/shaders/*",
            "**/alacritty/themes/*",
            "**/nvim/*",
            "**/tmux/plugins/*",
            "**/.DS_Store",
          },
          hidden = true,
        })
      end,
    },
    {
      "<leader>ft",
      desc = "Find Tools",
      function()
        local gen_items = function(tbl)
          local items = {}
          for _, tool in ipairs(tbl) do
            table.insert(items, { text = tool.name, exec = tool.execute })
          end
          return items
        end

        Snacks.picker.pick({
          source = "ToolBox",
          items = gen_items(require("config.tools")),
          format = "text",
          layout = {
            preset = "vscode", -- vscode | ivy | default | telescope | select | vertical | dropdown
          },
          confirm = function(picker, item)
            picker:close()

            local ok, res = pcall(item.exec)
            if not ok then
              error(res, 0)
            end
          end,
        })
      end,
    },
    {
      "<leader>fs",
      desc = "Find NPM Scripts",
      function()
        local pj_file = io.open(vim.fn.getcwd() .. "/package.json", "r")

        if not pj_file then
          vim.notify("No package.json detected...", "error")
          return
        end

        local content = pj_file:read("*a")
        pj_file:close()

        local pj = vim.fn.json_decode(content)

        local scripts = {}

        for k, _ in pairs(pj.scripts) do
          table.insert(scripts, { text = k })
        end

        Snacks.picker.pick({
          source = "scripts",
          items = scripts,
          format = "text",
          layout = {
            preset = "vscode",
          },
          confirm = function(picker, item)
            picker:close()
            local npm_command = string.format("npm run %s", item.text)
            local tmux_script = [[
      %s
      exit_code=$?
      if [ $exit_code -eq 0 ]; then
        sleep 1
        exit
      else
        echo "Command failed with exit code $exit_code. Press ENTER to close this pane."
        read
      fi
    ]]

            vim.fn.system(string.format("tmux split-window -h -d -p 20 '%s'", string.format(tmux_script, npm_command)))
          end,
        })
      end,
    },
    {
      "<leader>fw",
      desc = "Find TMUX Windows",
      function()
        local function get_tmux_windows()
          local windows_raw = vim.fn.system("tmux list-windows -F '#{window_index}: #{window_name}'")
          local windows = {}

          for window in windows_raw:gmatch("[^\r\n]+") do
            table.insert(windows, { text = window })
          end

          return windows
        end

        local windows = get_tmux_windows()

        Snacks.picker.pick({
          source = "tmux_windows",
          items = windows,
          format = "text",
          layout = {
            preset = "vscode",
          },
          confirm = function(picker, item)
            picker:close()
            local window_index = item.text:match("^(%d+):")
            if window_index then
              vim.fn.system(string.format("tmux select-window -t %s", window_index))
            end
          end,
        })
      end,
    },
    {
      "<leader>nn",
      desc = "New Note",
      function()
        Snacks.input({ icon = " ", title = "New Note:" }, function(input)
          local path = vim.fn.expand("~/dotfiles/notes/" .. input .. ".md")
          vim.cmd("edit " .. path)
        end)
      end,
    },
    {
      "<leader>nd",
      desc = "New Daily Note",
      function()
        local date = os.date("*t")
        local filename = string.format("%02d-%02d-%04d.md", date.day, date.month, date.year)
        local path = vim.fn.expand("~/dotfiles/notes/dailies/" .. filename)

        -- Create the directory if it doesn't exist
        local dir = vim.fn.expand("~/dotfiles/notes/dailies")
        if vim.fn.isdirectory(dir) == 0 then
          vim.fn.mkdir(dir, "p")
        end

        vim.cmd("edit " .. path)
      end,
    },
    {
      "<leader>fn",
      desc = "Find Note",
      function()
        Snacks.picker.files({ dirs = { "~/dotfiles/notes" } })
      end,
    },
    {
      "<leader>sn",
      desc = "Search in Notes",
      function()
        Snacks.picker.grep({ dirs = { "~/dotfiles/notes" } })
      end,
    },
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
