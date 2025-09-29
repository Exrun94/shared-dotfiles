return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1100,
  ---@module 'tokyonight'
  ---@type tokyonight.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    transparent = false,
    styles = {
      -- sidebars = "transparent",
      -- floats = "transparent",
      comments = { italic = true },
      keywords = { italic = true },
      functions = { italic = true, bold = true },
      variables = { bold = true },
      constants = { bold = true },
      types = { bold = true },
    },
    day_brightness = 1, -- Adjusts brightness for the day style (0 to 1)
    dim_inactive = true, -- Dims inactive windows
    lualine_bold = true, -- Bold section headers in lualine theme
    cache = true,
    plugins = {
      auto = true, -- Automatically enable needed plugins for lazy.nvim
    },
    on_colors = require("utils.colors").get_theme("tokyonight_alt"),

    ---@type tokyonight.Highlights
    on_highlights = function(hl, c)
      hl["@variable.member"] = { bold = true, fg = c.green1 }
      hl["@string"] = { bold = true, fg = c.green }

      -- hl.BetterTermSymbol = { bg = "#9DDBA3", fg = c.bg }
      hl.TabLineSel = { bg = "#1E2437", fg = "#98A4DE" }
      hl.TabLine = { bg = c.bg, fg = "#66677D" }
      hl.StatusLine = { bg = c.none }
      hl.TabLineFill = { bg = c.none }

      hl.BufferLineErrorSelected = { fg = c.fg }
      hl.BufferLineWarningSelected = { fg = c.fg }
      hl.BufferLineErrorDiagnostic = { fg = c.red }
      hl.BufferLineErrorDiagnosticSelected = { fg = c.red }
      hl.BufferLineWarningDiagnostic = { fg = c.yellow }
      hl.BufferLineWarningDiagnosticSelected = { fg = c.yellow }

      hl.WinSeparator = { fg = c.fg_gutter }
      hl.LspInlayHint = { fg = c.green1, bg = c.bg_highlight, bold = true }
      hl.FloatTitle = { bg = c.bg, fg = c.blue, bold = true }
      hl.SnacksPickerInputBorder = { bg = c.bg, fg = c.orange }
      hl.SnacksPickerBoxTitle = { bg = c.bg, fg = c.blue, bold = true }
      hl.NormalFloat = { bg = c.bg }
      hl.FloatBorder = { bg = c.bg, fg = c.blue }
      -- hl.PreProc = { fg = c.cyan, bold = true } -- import statement

      hl.Boolean = { fg = c.orange, bold = true }
      -- Cmp window
      hl.Pmenu = { bg = c.none or "NONE" }

      hl.BlinkCmpMenuSelection = { fg = c.none, bg = c.bg_highlight }
      hl.BlinkCmpLabelMatch = { fg = c.blue, bold = true }

      hl.BlinkCmpLabel = { fg = c.f }
      hl.BlinkCmpDocBorder = { fg = c.orange, bold = true }
      hl.BlinkCmpMenuBorder = { fg = c.orange, bold = true }

      -- Override some BlinkCmpKind<kind> colors
      hl.BlinkCmpKindSnippet = { fg = c.red, bold = true }
      hl.BlinkCmpKindLingua = { fg = c.green1, bold = true }
    end,
  },
}
