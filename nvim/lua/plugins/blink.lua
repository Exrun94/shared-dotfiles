-- https://github.com/saghen/blink.cmp
-- Documentation site: https://cmp.saghen.dev/

return {
  "saghen/blink.cmp",
  version = require("utils.os").is_mac() and "0.13.1" or (not vim.g.lazyvim_blink_main and "*"),
  build = vim.g.lazyvim_blink_main and require("utils.os").is_linux() and "cargo build --release",
  enabled = true,
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  opts = {
    appearance = {
      nerd_font_variant = "mono",
      kind_icons = {
        Copilot = " ",
        Git = "󰊤 ",
        Spell = "﬜",
        Lingua = " ",
      },
    },
    enabled = function()
      return not vim.list_contains(
        { "DressingInput", "TelescopePrompt", "minifiles", "scissors-snippet", "snacks_picker_input" },
        vim.bo.filetype
      ) and vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
    end,
    sources = {
      default = function(ctx)
        if vim.bo.filetype == "codecompanion" then
          return { "codecompanion" }
        else
          return { "lsp", "path", "buffer", "codecompanion" }
        end
      end,
      providers = {
        lsp = {
          name = "lsp",
          module = "blink.cmp.sources.lsp",
          score_offset = 100,
        },
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          -- score_offset = 1,
        },
        snippets = {
          name = "snippets",
          max_items = 5,
          module = "blink.cmp.sources.snippets",
          -- score_offset = 2,
          -- min_keyword_length = 1,
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          -- score_offset = 3,
          fallbacks = { "snippets", "buffer" },
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
        },
        lingua = {
          module = "blink-cmp-lingua",
          kind = "Lingua",
          name = "Lingua",
        },
      },
    },

    fuzzy = {
      use_frecency = false,
      use_proximity = false,
    },

    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      list = {
        -- Insert items while navigating the completion list.
        selection = { preselect = true, auto_insert = true },
        max_items = 1000,
      },
      keyword = {
        --     -- 'prefix' will fuzzy match on the text before the cursor
        --     -- 'full' will fuzzy match on the text before *and* after the cursor
        --     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        -- range = "prefix",
      },
      menu = {
        enabled = true,
        scrollbar = false,
        border = "rounded",
        -- auto_show = function(ctx)
        --   print(ctx)
        --   return not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
        -- end,
        draw = {
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "kind" },
          },
          treesitter = {}, -- override the default 'lsp' which applies colors to my BlinkCmpKind<kind>
        },
      },
      documentation = {
        auto_show_delay_ms = 200,
        auto_show = true,
        window = {
          border = "rounded",
        },
      },
      ghost_text = {
        enabled = false,
      },
    },

    snippets = {
      preset = "luasnip",
    },
    cmdline = {
      enabled = true,
      keymap = { preset = "inherit" },
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          -- or return { "buffer" } for suggestions
          return {}
        end
        -- Commands
        if type == ":" or type == "@" then
          return { "cmdline" }
        end
        return {}
      end,
      completion = {
        -- trigger = {
        --   show_on_blocked_trigger_characters = {},
        --   show_on_x_blocked_trigger_characters = {},
        -- },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = { auto_show = true },
        ghost_text = { enabled = true },
      },
    },

    -- https://cmp.saghen.dev/configuration/keymap.html#default
    keymap = {
      preset = "none",
      ["<Del>"] = {
        function(cmp)
          cmp.show({ providers = { "snippets" } })
        end,
      },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
  },
}
