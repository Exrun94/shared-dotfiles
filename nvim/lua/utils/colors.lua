local M = {}

M.colorschemes = {
  rose_pine = function(colors)
    colors.bg = "#191724" -- Base
    colors.bg_dark = "#1f1d2e" -- Base
    colors.bg_dark1 = "#1f1d2e" -- Surface
    colors.bg_highlight = "#292e42"
    colors.bg_statusline = "none"

    colors.fg = "#e0def4" -- Text
    colors.fg_dark = "#575279" -- Subtle
    colors.fg_gutter = "#3b4261"

    -- Accent colors
    colors.blue = "#a7b4e6" -- Iris
    colors.blue0 = "#3e8fb0" -- Enhanced Foam (more saturated)
    colors.blue1 = "#9ccfd8" -- Enhanced Foam (promise)
    colors.blue2 = "#286983" -- Pine
    colors.blue5 = "#c4a7e7" -- Iris
    colors.blue6 = "#56949f" -- Enhanced Foam
    colors.blue7 = "#286983" -- Highlight Med

    colors.comment = "#6e6a86" -- Muted
    colors.cyan = "#907aa9" -- Foam
    colors.dark3 = "#6e6a86" -- Muted
    colors.dark5 = "#908caa" -- Subtle

    colors.green = "#30838f" -- Pine
    colors.green1 = "#65bfd0" -- Enhanced Foam
    colors.green2 = "#9ccfd8" -- Enhanced Foam

    colors.magenta = "#c4a7e7" -- Iris
    colors.magenta2 = "#eb6f92" -- Enhanced Love (brighter)
    colors.orange = "#ea9a97" -- Rose
    colors.purple = "#c4a7e7" -- Iris
    colors.red = "#eb6f92" -- Enhanced Love
    colors.red1 = "#b4637a" -- Enhanced Love
    colors.teal = "#31748f" -- Pine
    colors.terminal_black = "#403d52" -- Highlight Med
    colors.yellow = "#e39e88" -- Gold

    colors.git = {
      add = "#65bfd0", -- Enhanced Foam
      change = "#c4a7e7", -- Iris
      delete = "#f07a9e", -- Enhanced Love
    }
  end,

  rose_pine_alt = function(colors)
    colors.bg = "#191724" -- Base
    colors.bg_dark = "#191724" -- Base
    colors.bg_dark1 = "#1f1d2e" -- Surface
    colors.bg_highlight = "#26233a" -- Overlay
    colors.bg_statusline = "none"

    colors.fg = "#e0def4" -- Text
    colors.fg_dark = "#908caa" -- Subtle
    colors.fg_gutter = "#26233a" -- Muted

    colors.blue = "#a7b4e6" -- Iris
    colors.blue0 = "#65bfd0" -- Enhanced Foam (more saturated)
    colors.blue1 = "#31748f" -- Enhanced Foam
    colors.blue2 = "#31748f" -- Pine
    colors.blue5 = "#c4a7e7" -- Iris
    colors.blue6 = "#65bfd0" -- Enhanced Foam
    colors.blue7 = "#403d52" -- Highlight Med

    colors.comment = "#6e6a86" -- Muted
    colors.cyan = "#907aa9" -- Foam
    colors.dark3 = "#6e6a86" -- Muted
    colors.dark5 = "#908caa" -- Subtle

    colors.green = "#31748f" -- Pine
    colors.green1 = "#65bfd0" -- Enhanced Foam
    colors.green2 = "#65bfd0" -- Enhanced Foam

    colors.magenta = "#c4a7e7" -- Iris
    colors.magenta2 = "#f07a9e" -- Enhanced Love (brighter)
    colors.orange = "#e39e88" -- Rose
    colors.purple = "#c4a7e7" -- Iris
    colors.red = "#f07a9e" -- Enhanced Love
    colors.red1 = "#f07a9e" -- Enhanced Love
    colors.teal = "#31748f" -- Pine
    colors.terminal_black = "#403d52" -- Highlight Med
    colors.yellow = "#e39e88" -- Gold

    colors.git = {
      add = "#65bfd0", -- Enhanced Foam
      change = "#c4a7e7", -- Iris
      delete = "#f07a9e", -- Enhanced Love
    }
  end,

  tokyonight_alt = function(colors)
    -- colors.bg_statusline = "none"
    colors.bg_statusline = "#151723"
    colors.bg = "#151723"
    colors.bg_dark = "#151723"
    colors.bg_dark1 = "#151723"
    colors.bg_highlight = "#292e42"
    colors.blue = "#7aa2f7"
    colors.blue0 = "#3d59a1"
    colors.blue1 = "#2ac3de"
    colors.blue2 = "#0db9d7"
    colors.blue5 = "#89ddff"
    colors.blue6 = "#b4f9f8"
    colors.blue7 = "#394b70"
    colors.comment = "#565f89"
    colors.cyan = "#7dcfff"
    colors.dark3 = "#545c7e"
    colors.dark5 = "#737aa2"
    colors.fg = "#c0caf5"
    colors.fg_dark = "#a9b1d6"
    colors.fg_gutter = "#3b4261"
    colors.green = "#9ece6a"
    colors.green1 = "#73daca"
    colors.green2 = "#41a6b5"
    colors.magenta = "#bb9af7"
    colors.magenta2 = "#ff007c"
    colors.orange = "#ff9e64"
    colors.purple = "#9d7cd8"
    colors.red = "#f7768e"
    colors.red1 = "#db4b4b"
    colors.teal = "#1abc9c"
    colors.terminal_black = "#414868"
    colors.yellow = "#e0af68"
    colors.git = {
      add = "#449dab",
      change = "#6183bb",
      delete = "#914c54",
    }
  end,
}

---@alias TokyoNightTheme "rose_pine_alt"|"rose_pine"|"tokyonight_alt"
---@param theme? TokyoNightTheme
---@return function
function M.get_theme(theme)
  theme = theme or "tokyonight_alt"

  if not M.colorschemes[theme] then
    vim.notify("Theme '" .. theme .. "' not found, using default", vim.log.levels.WARN)
    return M.colorschemes.tokyonight_alt
  end

  return M.colorschemes[theme]
end

return M
