---@type Base46Table
local M = {}

-- Monochrome Focus Theme for NvChad
-- Strictly grayscale with desaturated red (errors) and green (success/strings)

M.base_30 = {
  white = "#d4d4d4",
  black = "#0d0d0d",        -- Main background
  darker_black = "#080808", -- Sidebar/Terminal bg
  black2 = "#151515",       -- Secondary backgrounds
  one_bg = "#262626",       -- Non-text UI elements / Active line
  one_bg2 = "#333333",      -- Borders/Separators
  one_bg3 = "#404040",
  grey = "#525252",         -- Comments / Gutter grey
  grey_fg = "#737373",      -- Punctuation
  grey_fg2 = "#8a8a8a",     -- Keywords / Secondary text
  light_grey = "#a3a3a3",
  line = "#262626",         -- Split lines

  -- The Focus Colors (Desaturated)
  red = "#8c7373",          -- Errors, Exceptions, Git Deletes
  green = "#738c7a",        -- Success, Strings, Git Adds
  vibrant_green = "#738c7a",

  -- Muting ALL distracting standard colors to shades of gray
  baby_pink = "#a3a3a3",
  pink = "#a3a3a3",
  nord_blue = "#8a8a8a",
  blue = "#8a8a8a",
  seablue = "#8a8a8a",
  yellow = "#8a8a8a",       -- Warnings are just gray now
  sun = "#a3a3a3",
  purple = "#8a8a8a",
  dark_purple = "#737373",
  teal = "#8a8a8a",
  orange = "#a3a3a3",
  cyan = "#8a8a8a",

  statusline_bg = "#151515",
  lightbg = "#262626",
  pmenu_bg = "#151515",
  folder_bg = "#8a8a8a",
}

-- Syntax Highlighting
M.base_16 = {
  base00 = "#0d0d0d", -- Main Background
  base01 = "#151515", -- Lighter Background (Status bars)
  base02 = "#262626", -- Selection Background
  base03 = "#525252", -- Comments, Invisibles (Pushed back)
  base04 = "#737373", -- Dark Foreground (Operators, Delimiters)
  base05 = "#d4d4d4", -- Default Foreground (Variables)
  base06 = "#e5e5e5", -- Light Foreground
  base07 = "#ffffff", -- Lightest Foreground
  base08 = "#8a8a8a", -- Variables, XML Tags (Forced Gray)
  base09 = "#a3a3a3", -- Integers, Boolean, Constants (Forced Gray)
  base0A = "#8a8a8a", -- Classes, Types (Forced Gray)
  base0B = "#a3a3a3", -- Strings (Forced Gray)
  base0C = "#8a8a8a", -- Support, Regex (Forced Gray)
  base0D = "#d4d4d4", -- Functions, Methods (Bright Gray/White)
  base0E = "#737373", -- Keywords, Storage, Selectors (Dark Gray)
  base0F = "#737373", -- Deprecated / Syntax Errors (Forced Gray)
}

M.type = "dark"

M.polish_hl = {
  defaults = {
    -- Force Diagnostics to follow the focus rule (No yellow/blue noise)
    DiagnosticError = { fg = M.base_30.red },
    DiagnosticWarn = { fg = M.base_30.grey_fg2 }, -- Warnings are just gray
    DiagnosticInfo = { fg = M.base_30.grey_fg },  -- Info is darker gray
    DiagnosticHint = { fg = M.base_30.grey },     -- Hints are pushed way back

    -- Git Diff distinctions
    DiffAdd = { fg = M.base_30.green, bg = "#131714" }, -- Very faint green bg tint
    DiffChange = { fg = M.base_30.white, bg = "#262626" },
    DiffDelete = { fg = M.base_30.red, bg = "#171313" }, -- Very faint red bg tint

    -- Logic/Flow Control
    Keyword = { fg = M.base_16.base0E, bold = true },
    Conditional = { fg = M.base_16.base0E, bold = true },
    Repeat = { fg = M.base_16.base0E, bold = true },
    Statement = { fg = M.base_16.base0E, bold = true },
    Function = { fg = M.base_16.base0D, bold = true },

    -- Types/Classes
    Type = { fg = M.base_16.base0A, bold = true },
    Structure = { fg = M.base_16.base0A, bold = true },

    -- Data/Strings/Booleans (Legacy)
    String = { fg = M.base_16.base0B, italic = true },
    Constant = { fg = M.base_16.base09, italic = true },
    Number = { fg = M.base_16.base09 },
    Boolean = { fg = M.base_16.base09, bold = true },

    -- Explicit Treesitter Overrides (Kills the purple booleans)
    ["@boolean"] = { fg = M.base_16.base09, bold = true },
    ["@constant.builtin"] = { fg = M.base_16.base09, bold = true },
    ["@number"] = { fg = M.base_16.base09 },
    ["@string"] = { fg = M.base_16.base0B, italic = true },

    -- Brackets and Punctuation explicitly grayed out
    ["@punctuation.bracket"] = { fg = M.base_30.grey_fg },
    ["@punctuation.delimiter"] = { fg = M.base_30.grey_fg },
    ["@punctuation.special"] = { fg = M.base_30.grey_fg },

    -- Comments (Receded)
    Comment = { fg = M.base_16.base03, italic = true },

    -- UI Polish
    CursorLine = { bg = M.base_30.one_bg },
    MatchParen = { bg = M.base_30.one_bg3, bold = true },
    Error = { fg = M.base_30.red, bold = true },
  },
}

return M
