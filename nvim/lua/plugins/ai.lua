return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionActions",
    "CodeCompanionAdd",
  },
  keys = {
    { "<leader>a+", ":CodeCompanionChat Add<cr>", mode = { "v" }, desc = "Code Companion Add" },
    { "<leader>aa", ":CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Code Companion Actions" },
    { "<leader>ab", ":CodeCompanion /buffer<cr>", mode = { "n" }, desc = "Code Companion Buffer" },
    {
      "<F1>",
      function()
        require("utils.beepboop").play_audio("button")
        vim.cmd("CodeCompanionChat Toggle")
      end,
      mode = { "n", "v", "i" },
      desc = "Code Companion Chat",
    },
    { "<leader>ad", ":CodeCompanion /doc<cr>", mode = { "v" }, desc = "Documentation" },
    { "<leader>ae", ":CodeCompanion /explain<cr>", mode = { "n", "v" }, desc = "Explain" },
    { "<leader>af", ":CodeCompanion /fix<cr>", mode = { "v" }, desc = "Fix" },
    { "<leader>ai", ":CodeCompanion<cr>", mode = { "n", "v" }, desc = "Inline Prompt" },
    { "<leader>al", ":CodeCompanion /lsp<cr>", mode = { "n", "v" }, desc = "LSP" },
    { "<leader>aR", ":CodeCompanion /cr<cr>", mode = { "n" }, desc = "Code Review" },
    { "<leader>ap", ":CodeCompanion /pr<cr>", mode = { "n" }, desc = "PR" },
    { "<leader>ag", ":CodeCompanion /presentation<cr>", mode = { "n" }, desc = "Presentation Assistant" },
    { "<leader>ar", ":CodeCompanion /refactor<cr>", mode = { "v" }, desc = "Refactor" },
    { "<leader>as", ":CodeCompanionSave<cr>", mode = { "n" }, desc = "Save Chat" },
    { "<leader>aC", ":CodeCompanion /commit<cr>", mode = { "n" }, desc = "commit" },
  },
  opts = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = "claude-4.0-sonnet",
          },
        },
      })
    end,
    display = {
      diff = { enabled = false },
      chat = { show_settings = false, window = { layout = "vertical", width = 0.45, height = 0.9 } },
    },
    -- yank_code = {
    --   modes = {
    --     n = "gy",
    --   },
    --   index = 8,
    --   callback = "keymaps.yank_code",
    --   description = "Yank Code",
    -- },
    strategies = {
      chat = {
        adapter = "anthropic",
        roles = {
          user = "Georgi Chochev",
          llm = function(adapter)
            local model_name = ""
            -- Try to get the model name from the adapter
            if adapter.schema and adapter.schema.model and adapter.schema.model.default then
              local model = adapter.schema.model.default
              if type(model) == "function" then
                model = model(adapter)
              end
              model_name = " - " .. model
            end

            return "" .. adapter.formatted_name .. model_name .. ""
          end,
        },
        tools = {},
        slash_commands = {
          ["buffer"] = {
            opts = {
              provider = "snacks",
            },
          },
          ["help"] = {
            opts = {
              provider = "snacks",
              max_lines = 1000,
            },
          },
          ["file"] = {
            opts = {
              provider = "snacks",
            },
          },
          ["symbols"] = {
            opts = {
              provider = "snacks",
            },
          },
          -- ["git_commit"] = require("plugins.codecompanion.slash_commands.git_commit"),
          ["code_review"] = require("plugins.codecompanion.slash_commands.code_review"),
          ["git_files"] = require("plugins.codecompanion.slash_commands.git_files"),
        },
      },
      inline = {
        adapter = "anthropic",
      },
    },
    prompt_library = require("plugins.codecompanion.prompt_library"),
  },
  init = function()
    local function save_codecompanion_buffer(bufnr)
      -- Get buffer number if not provided
      bufnr = bufnr or vim.api.nvim_get_current_buf()

      -- Verify it's a CodeCompanion buffer
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if not bufname:match("%[CodeCompanion%]") then
        vim.notify("Not a CodeCompanion buffer", vim.log.levels.ERROR)
        return
      end

      -- Get user input for file name
      Snacks.input.input({
        prompt = "CodeCompanion Save Chat",
      }, function(name)
        if not name or name == "" then
          vim.notify("Save cancelled", vim.log.levels.INFO)
          return
        end

        local save_dir = vim.fn.expand("~/dotfiles/codecompanion/")
        local timestamp = os.date("%Y-%m-%d_%H%M%S")
        local safe_name = name:gsub("[^%w%-%_]", "_") -- Replace non-alphanumeric chars
        local save_path = save_dir .. safe_name .. "_" .. timestamp .. ".md"

        -- Write buffer content to file
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local file = io.open(save_path, "w")
        if file then
          file:write(table.concat(lines, "\n"))
          file:close()
          vim.notify("Chat saved to: " .. save_path, vim.log.levels.INFO)
        else
          vim.notify("Failed to save chat", vim.log.levels.ERROR)
        end
      end)
    end

    vim.api.nvim_create_user_command("CodeCompanionSave", function()
      save_codecompanion_buffer()
    end, {})
  end,
}
