-- Monolith Dark
-- A strict monochrome theme relying on contrast and typography
-- Designed for clarity and focus.

---@type Base46Table
local M = {}

-- Palette Definition (Shades of Grey)
-- darkest: #101010 (Main BG)
-- darker:  #181818 (Sidebar/Status)
-- dark:    #252525 (Selection/Lines)
-- mid:     #666666 (Comments)
-- light:   #a0a0a0 (Strings/Data)
-- lighter: #d0d0d0 (Variables)
-- white:   #ffffff (Keywords/Focus)

-- UI Colors
M.base_30 = {
  white = "#ffffff",
  black = "#101010",        -- Main background (Soft black, not pitch black)
  darker_black = "#0d0d0d", -- Sidebar/Terminal bg
  black2 = "#181818",       -- Secondary backgrounds
  one_bg = "#1f1f1f",       -- Non-text UI elements
  one_bg2 = "#2a2a2a",      -- Borders/Separators
  one_bg3 = "#353535",
  grey = "#505050",         -- Gutter grey
  grey_fg = "#606060",
  grey_fg2 = "#707070",
  light_grey = "#808080",
  line = "#1f1f1f",         -- Split lines

  -- Mapping standard colors to greys for UI elements (Git, Statusline, etc)
  -- We vary brightness to indicate status intensity
  red = "#ffffff",           -- Errors (High contrast)
  baby_pink = "#e0e0e0",
  pink = "#d0d0d0",
  green = "#909090",         -- Success/Add
  vibrant_green = "#a0a0a0",
  nord_blue = "#b0b0b0",
  blue = "#c0c0c0",          -- Info/Folder
  seablue = "#b0b0b0",
  yellow = "#d0d0d0",        -- Warning
  sun = "#e0e0e0",
  purple = "#c0c0c0",
  dark_purple = "#b0b0b0",
  teal = "#a0a0a0",
  orange = "#d0d0d0",
  cyan = "#b0b0b0",

  statusline_bg = "#181818",
  lightbg = "#252525",
  pmenu_bg = "#181818",
  folder_bg = "#808080",
}

-- Syntax Highlighting
M.base_16 = {
  base00 = "#101010", -- Main Background
  base01 = "#181818", -- Lighter Background (Status bars)
  base02 = "#252525", -- Selection Background
  base03 = "#555555", -- Comments, Invisibles (Pushed back)
  base04 = "#808080", -- Dark Foreground (Operators, Delimiters)
  base05 = "#bbbbbb", -- Default Foreground (Variables)
  base06 = "#d0d0d0", -- Light Foreground
  base07 = "#ffffff", -- Lightest Foreground
  base08 = "#d0d0d0", -- Variables, XML Tags (Bright Grey)
  base09 = "#c0c0c0", -- Integers, Boolean, Constants
  base0A = "#e0e0e0", -- Classes, Types (Very Bright)
  base0B = "#888888", -- Strings (Mid Grey)
  base0C = "#bbbbbb", -- Support, Regex
  base0D = "#ffffff", -- Functions, Methods (White)
  base0E = "#ffffff", -- Keywords, Storage, Selectors (White)
  base0F = "#bbbbbb", -- Deprecated
}

M.type = "dark"

M.polish_hl = {
  defaults = {
    -- Logic/Flow Control is Bold and Bright
    Keyword = { fg = M.base_30.white, bold = true },
    Conditional = { fg = M.base_30.white, bold = true },
    Repeat = { fg = M.base_30.white, bold = true },
    Statement = { fg = M.base_30.white, bold = true },
    Function = { fg = M.base_30.white, bold = true },

    -- Types/Classes are Bold but slightly softer
    Type = { fg = M.base_16.base0A, bold = true },
    Structure = { fg = M.base_16.base0A, bold = true },

    -- Data/Strings are Italic and Mid-Grey
    String = { fg = M.base_16.base0B, italic = true },
    Constant = { fg = M.base_16.base09, italic = true },
    Number = { fg = M.base_16.base09 },
    Boolean = { fg = M.base_16.base09, bold = true },

    -- Comments are Dark and Italic (Receded)
    Comment = { fg = M.base_16.base03, italic = true },

    -- UI Polish
    CursorLine = { bg = "#1a1a1a" },
    MatchParen = { bg = "#404040", bold = true }, -- Highlight matching brackets clearly

    -- Variable adjustments
    ["@variable"] = { fg = M.base_16.base05 },
    ["@parameter"] = { fg = M.base_16.base05, italic = true },
    ["@field"] = { fg = M.base_16.base05 },
    ["@property"] = { fg = M.base_16.base05 },

    -- Git Diff distinctions (using brightness and style)
    DiffAdd = { fg = "#aaaaaa", bg = "#202020" },
    DiffChange = { fg = "#dddddd", bg = "#202020" },
    DiffDelete = { fg = "#444444", bg = "#101010" },
  },
}

return M
