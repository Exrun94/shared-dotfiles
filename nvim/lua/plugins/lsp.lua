return {
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "<leader>ss", false }

      -- Extend existing opts
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        vtsls = {
          settings = {
            complete_function_calls = false,
          },
        },
        bashls = {
          cmd = { "bash-language-server", "start" },
          filetypes = { "sh", "bash", "zsh" },
        },
        html = {},
        jsonls = {},
        cssls = {},

        css_variables = {
          cmd = { "css-variables-language-server", "--stdio" },
          filetypes = { "css", "scss", "less" },
          settings = {
            cssVariables = {
              lookupFiles = {
                "**/*.less",
                "**/*.scss",
                "**/*.sass",
                "**/*.css",
                "**/node_modules/@siteground/styleguide/lib/styles/main.scss",
                "**/node_modules/@siteground/styleguide/lib/styles/**/*.scss",
              },
              blacklistFolders = {
                "**/.cache",
                "**/.DS_Store",
                "**/.git",
                "**/.hg",
                "**/.next",
                "**/.svn",
                "**/bower_components",
                "**/CVS",
                "**/dist",
                "**/node_modules/[^@]*/**",
                "**/node_modules/@(?!siteground)/**",
                "**/tests",
                "**/tmp",
              },
            },
          },
        },
        tailwindcss = {
          hovers = true,
          suggestions = true,
          root_dir = function(fname)
            local root_pattern =
              require("lspconfig").util.root_pattern("tailwind.config.cjs", "tailwind.config.js", "postcss.config.js")
            return root_pattern(fname)
          end,
        },
        gradle_ls = {},
        gopls = {},
      })

      -- Override specific options
      opts.inlay_hints = { enabled = false }
      opts.codelens = { enabled = false }
      opts.ui = {
        windows = {
          default_options = {
            border = "rounded",
          },
        },
      }
      opts.diagnostics = {
        virtual_text = false,
        signs = true,
        float = { border = "rounded" },
      }

      return opts
    end,
  },
}
