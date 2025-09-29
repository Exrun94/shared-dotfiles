local colors = {
  blue = "#7aa2f7",
  magenta = "#bb9af7",
  bg = "#151723",
  fg = "#c0caf5",
  red = "#f7768e",
  grey = "#292e42",
  green = "#9ece6a",
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.green },
    b = { fg = colors.fg, bg = colors.grey },
    c = { fg = colors.fg },
  },

  insert = { a = { fg = colors.bg, bg = colors.blue } },
  visual = { a = { fg = colors.bg, bg = colors.magenta } },
  replace = { a = { fg = colors.bg, bg = colors.red } },

  inactive = {
    a = { fg = colors.fg, bg = colors.bg },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg },
  },
}
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = bubbles_theme,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            {
              function()
                return require("lazydo").get_lualine_stats()
              end,
              cond = function()
                return require("lazydo")._initialized
              end,
            },
            require("plugins.codecompanion.lualine"),
            -- "lsp_status",
          },
          lualine_y = {
            require("recorder").recordingStatus,
          },
          lualine_z = { require("recorder").displaySlots },
        },
      })
      if vim.env.TMUX ~= nil then
        local Debounce = require("utils.debounce")
        local lualine_nvim_opts = require("lualine.utils.nvim_opts")
        local base_set = lualine_nvim_opts.set

        local tpipeline_update = Debounce(function()
          vim.cmd("silent! call tpipeline#update()")
        end, {
          threshold = 20,
        })

        ---@diagnostic disable-next-line: duplicate-set-field
        lualine_nvim_opts.set = function(name, val, scope)
          if name == "statusline" then
            if scope and scope.window == vim.api.nvim_get_current_win() then
              vim.g.tpipeline_statusline = val
              tpipeline_update()
            end
            return
          end
          return base_set(name, val, scope)
        end
      end
    end,
  },
  {
    "vimpostor/vim-tpipeline",
    event = "VeryLazy",
    init = function()
      vim.g.tpipeline_statusline = ""
    end,
    config = function()
      vim.g.tpipeline_statusline = ""
      vim.o.laststatus = 3
      vim.defer_fn(function()
        vim.o.laststatus = 3
      end, 0)
      vim.o.fillchars = "stl: ,stlnc: ,horiz:─,vert:│,horizup:┴,horizdown:┬,vertleft:┤,vertright:┬"
      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "laststatus",
        callback = function()
          if vim.o.laststatus ~= 3 then
            vim.notify("Auto-setting laststatus to 3")
            vim.o.laststatus = 3
          end
        end,
      })
    end,
    cond = function()
      return vim.env.TMUX ~= nil
    end,
    dependencies = {
      "nvim-lualine/lualine.nvim",
    },
  },
}
