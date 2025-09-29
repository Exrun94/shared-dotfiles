return {
  {
    "echasnovski/mini.icons",
  },
  {
    "echasnovski/mini.pairs",
    opts = {
      -- In which modes mappings from this `config` should be created
      modes = { insert = true, command = false, terminal = false },

      -- Global mappings. Each right hand side should be a pair information, a
      -- table with at least these fields (see more in |MiniPairs.map|):
      -- - <action> - one of 'open', 'close', 'closeopen'.
      -- - <pair> - two character string for pair to be used.
      -- By default pair is not inserted after `\`, quotes are not recognized by
      -- `<CR>`, `'` does not insert pair after a letter.
      -- Only parts of tables can be tweaked (others will use these defaults).
      mappings = {
        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        ["["] = {
          action = "open",
          pair = "[]",
          neigh_pattern = ".[%s%z%)}%]]",
          register = { cr = false },
          -- foo|bar -> press "[" -> foo[bar
          -- foobar| -> press "[" -> foobar[]
          -- |foobar -> press "[" -> [foobar
          -- | foobar -> press "[" -> [] foobar
          -- foobar | -> press "[" -> foobar []
          -- {|} -> press "[" -> {[]}
          -- (|) -> press "[" -> ([])
          -- [|] -> press "[" -> [[]]
        },
        ["{"] = {
          action = "open",
          pair = "{}",
          -- neigh_pattern = ".[%s%z%)}]",
          neigh_pattern = ".[%s%z%)}%]]",
          register = { cr = false },
          -- foo|bar -> press "{" -> foo{bar
          -- foobar| -> press "{" -> foobar{}
          -- |foobar -> press "{" -> {foobar
          -- | foobar -> press "{" -> {} foobar
          -- foobar | -> press "{" -> foobar {}
          -- (|) -> press "{" -> ({})
          -- {|} -> press "{" -> {{}}
        },
        ["("] = {
          action = "open",
          pair = "()",
          -- neigh_pattern = ".[%s%z]",
          neigh_pattern = ".[%s%z%)]",
          register = { cr = false },
          -- foo|bar -> press "(" -> foo(bar
          -- foobar| -> press "(" -> foobar()
          -- |foobar -> press "(" -> (foobar
          -- | foobar -> press "(" -> () foobar
          -- foobar | -> press "(" -> foobar ()
        },
        -- Single quote: Prevent pairing if either side is a letter
        ['"'] = {
          action = "closeopen",
          pair = '""',
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
        -- Single quote: Prevent pairing if either side is a letter
        ["'"] = {
          action = "closeopen",
          pair = "''",
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
        -- Backtick: Prevent pairing if either side is a letter
        ["`"] = {
          action = "closeopen",
          pair = "``",
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
      },
    },
  },
  {
    "echasnovski/mini.ai",
    version = "*",
    lazy = false,
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        -- n_lines = 200,
        custom_textobjects = {
          x = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      })
    end,
    --[[
        daa - delete around argument
        dif - delete inside function
        daf - delete around function
        dilf - l stands for last
        danf - n stands for next
        ]]
    --
  },
  {
    "echasnovski/mini.splitjoin",
    version = "*",
    lazy = false,
    opts = {},
  },
  {
    "echasnovski/mini.fuzzy",
    version = "*",
    lazy = false,
    opts = {},
    -- gS toggle split/join
  },
  {
    "echasnovski/mini.files",
    version = false,
    keys = {
      {
        "<leader>e",
        function()
          require("utils.beepboop").play_audio("summon")
          require("mini.files").open(vim.api.nvim_buf_get_name(0))
        end,
        desc = "Files",
      },
    },
    opts = {
      options = {
        use_as_default_explorer = true,
        permanent_delete = false,
      },
      mappings = {
        close = "q",
        go_in = "",
        go_in_plus = "l",
        go_out = "",
        go_out_plus = "h",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "y",
        trim_left = "<",
        trim_right = ">",
      },
      windows = {
        -- Maximum number of windows to show side by side
        max_number = math.huge,
        -- Whether to show preview of file/directory under cursor
        preview = false,
        -- Width of focused window
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 80,
      },
    },
    init = function()
      -- TODO: currently moving entire dirs do not work
      -- Working solution for rename
      vim.api.nvim_create_autocmd("User", {
        desc = "Update TypeScript references when renaming files with mini.files",
        pattern = "MiniFilesActionRename",
        callback = function(args)
          local from_path = args.data.from
          local to_path = args.data.to

          -- 1. Send the workspace/didRenameFiles notification
          local changes = {
            files = {
              {
                oldUri = vim.uri_from_fname(from_path),
                newUri = vim.uri_from_fname(to_path),
              },
            },
          }

          local ts_client
          for _, client in ipairs(vim.lsp.get_clients()) do
            if client.name == "vtsls" or client.name == "tsserver" then
              ts_client = client
            end

            if
              client.server_capabilities.workspace
              and client.server_capabilities.workspace.fileOperations
              and client.server_capabilities.workspace.fileOperations.didRename
            then
              client.notify("workspace/didRenameFiles", changes)
            end
          end

          if not ts_client then
            return
          end

          -- 2. Reload TypeScript projects to ensure references are updated
          vim.defer_fn(function()
            ts_client.request("workspace/executeCommand", {
              command = "typescript.reloadProjects",
            })

            vim.notify("Updated references for renamed file", vim.log.levels.INFO)
          end, 200)
        end,
      })

      -- Function to update TypeScript references
      local function update_ts_references(from_path, to_path)
        vim.notify("Updating TypeScript references: " .. from_path .. " → " .. to_path, vim.log.levels.INFO)

        -- Find TypeScript client
        local ts_client
        for _, client in ipairs(vim.lsp.get_clients()) do
          if client.name == "vtsls" or client.name == "tsserver" then
            ts_client = client
            break
          end
        end

        if not ts_client then
          vim.notify("No TypeScript LSP server found", vim.log.levels.WARN)
          return
        end

        -- Send the workspace/didRenameFiles notification
        local changes = {
          files = {
            {
              oldUri = vim.uri_from_fname(from_path),
              newUri = vim.uri_from_fname(to_path),
            },
          },
        }

        -- Step 1: Notify about the file rename
        ts_client.notify("workspace/didRenameFiles", changes)

        -- Step 2: Initial project reload
        vim.defer_fn(function()
          ts_client.request("workspace/executeCommand", {
            command = "typescript.reloadProjects",
          })

          -- Step 3: After reload, try a more direct approach
          vim.defer_fn(function()
            -- Use a direct tsserver request to update imports
            ts_client.request("workspace/executeCommand", {
              command = "typescript.tsserverRequest",
              arguments = { "UpdateOpen", {} },
            })

            -- Final project reload to ensure changes are applied
            vim.defer_fn(function()
              ts_client.request("workspace/executeCommand", {
                command = "typescript.reloadProjects",
              })
              vim.notify("TypeScript references update completed", vim.log.levels.INFO)
            end, 200)
          end, 300)
        end, 200)
      end

      -- Helper to store the last move operation
      local last_move = {}

      -- Save the move with proper handling of mini.files context
      vim.api.nvim_create_autocmd("User", {
        desc = "Track file moves from mini.files",
        pattern = "MiniFilesActionMove",
        callback = function(args)
          local from_path = args.data.from
          local to_path = args.data.to

          -- Save the move for later use
          last_move = {
            from = from_path,
            to = to_path,
            is_ts_file = from_path:match("%.tsx?$")
              or from_path:match("%.jsx?$")
              or to_path:match("%.tsx?$")
              or to_path:match("%.jsx?$"),
          }

          -- Schedule the update outside of the mini.files context
          if last_move.is_ts_file then
            vim.notify("TypeScript file moved, will update references shortly...", vim.log.levels.INFO)

            -- Use a longer delay to escape mini.files context completely
            vim.defer_fn(function()
              update_ts_references(from_path, to_path)
            end, 1000) -- 1 second delay to ensure we're outside mini.files context
          end
        end,
      })

      -- Command to update using the last move (for manual use if needed)
      vim.api.nvim_create_user_command("TsUpdateLastMove", function()
        if last_move.from and last_move.to then
          update_ts_references(last_move.from, last_move.to)
        else
          vim.notify("No recent move operation found", vim.log.levels.WARN)
        end
      end, {})

      -- Command for manual updates with explicit paths
      vim.api.nvim_create_user_command("TsUpdateImportsAfterMove", function(opts)
        -- Get the arguments for old and new paths
        local args = opts.fargs
        if #args ~= 2 then
          vim.notify("Usage: TsUpdateImportsAfterMove old_path new_path", vim.log.levels.ERROR)
          return
        end

        update_ts_references(args[1], args[2])
      end, {
        nargs = "*",
        complete = "file",
      })
      -- Code shamelessly stolen from https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/plugins/minifiles.lua

      local function map_split(buf_id, lhs, direction)
        local minifiles = require("mini.files")

        local function rhs()
          local window = minifiles.get_explorer_state().target_window

          -- Noop if the explorer isn't open or the cursor is on a directory.
          if window == nil or minifiles.get_fs_entry().fs_type == "directory" then
            return
          end

          -- Make a new window and set it as target.
          local new_target_window
          vim.api.nvim_win_call(window, function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
          end)

          minifiles.set_target_window(new_target_window)

          -- Go in and close the explorer.
          minifiles.go_in({ close_on_file = true })
        end

        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. string.sub(direction, 12) })
      end

      vim.api.nvim_create_autocmd("User", {
        desc = "Add rounded corners to minifiles window",
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          vim.api.nvim_win_set_config(args.data.win_id, { border = "rounded" })
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        desc = "Add minifiles split keymaps",
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          map_split(buf_id, "<C-h>", "belowright horizontal")
          map_split(buf_id, "<C-v>", "belowright vertical")
        end,
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    recommended = true,
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local opts = LazyVim.opts("mini.surround")
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.find, desc = "Find Right Surrounding" },
        { opts.mappings.find_left, desc = "Find Left Surrounding" },
        { opts.mappings.highlight, desc = "Highlight Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
}
