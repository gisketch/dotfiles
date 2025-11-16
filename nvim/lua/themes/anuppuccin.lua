-- AnuPpuccin Light theme for Base46
-- Based on AnuPpuccin for Obsidian (uses Catppuccin Latte)
-- Soothing pastel theme with great readability

---@type Base46Table
local M = {}

-- Catppuccin Latte colors
local rosewater = "#dc8a78"
local flamingo = "#dd7878"
local pink = "#ea76cb"
local mauve = "#8839ef"
local red = "#d20f39"
local maroon = "#e64553"
local peach = "#fe640b"
local yellow = "#df8e1d"
local green = "#40a02b"
local teal = "#179299"
local sky = "#04a5e5"
local sapphire = "#209fb5"
local blue = "#1e66f5"
local lavender = "#7287fd"
local text = "#4c4f69"
local subtext1 = "#5c5f77"
local subtext0 = "#6c6f85"
local overlay2 = "#7c7f93"
local overlay1 = "#8c8fa1"
local overlay0 = "#9ca0b0"
local surface2 = "#acb0be"
local surface1 = "#bcc0cc"
local surface0 = "#ccd0da"
local base = "#eff1f5"
local mantle = "#e6e9ef"
local crust = "#dce0e8"

-- UI
M.base_30 = {
  white = text,
  black = base, -- main background
  darker_black = mantle,
  black2 = crust,
  one_bg = mantle, -- a bit lighter than black
  one_bg2 = crust,
  one_bg3 = surface0,
  grey = overlay0,
  grey_fg = overlay1,
  grey_fg2 = overlay2,
  light_grey = subtext0,
  red = red,
  baby_pink = flamingo,
  pink = pink,
  line = surface0, -- for lines like vertsplit
  green = green,
  vibrant_green = teal,
  nord_blue = sapphire,
  blue = blue,
  seablue = sky,
  yellow = yellow,
  sun = peach,
  purple = mauve,
  dark_purple = mauve,
  teal = teal,
  orange = peach,
  cyan = sapphire,
  statusline_bg = mantle,
  lightbg = surface0,
  pmenu_bg = blue,
  folder_bg = blue,
}

-- Syntax highlighting colors based on base16
M.base_16 = {
  base00 = base,      -- Default Background
  base01 = mantle,    -- Lighter Background (Used for status bars, line number and folding marks)
  base02 = surface0,  -- Selection Background
  base03 = overlay0,  -- Comments, Invisibles, Line Highlighting
  base04 = overlay1,  -- Dark Foreground (Used for status bars)
  base05 = text,      -- Default Foreground, Caret, Delimiters, Operators
  base06 = subtext1,  -- Light Foreground (Not often used)
  base07 = subtext0,  -- Light Background (Not often used)
  base08 = red,       -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
  base09 = peach,     -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
  base0A = yellow,    -- Classes, Markup Bold, Search Text Background
  base0B = green,     -- Strings, Inherited Class, Markup Code, Diff Inserted
  base0C = teal,      -- Support, Regular Expressions, Escape Characters, Markup Quotes
  base0D = blue,      -- Functions, Methods, Attribute IDs, Headings
  base0E = mauve,     -- Keywords, Storage, Selector, Markup Italic, Diff Changed
  base0F = rosewater, -- Deprecated, Opening/Closing Embedded Language Tags
}

M.type = "light"

M.polish_hl = {
  defaults = {
    Comment = {
      italic = true,
    },
  },
  treesitter = {
    ["@keyword"] = { fg = mauve },
    ["@keyword.return"] = { fg = mauve },
    ["@keyword.function"] = { fg = mauve },
    ["@variable"] = { fg = text },
    ["@variable.builtin"] = { fg = red },
    ["@function"] = { fg = blue },
    ["@function.builtin"] = { fg = peach },
    ["@string"] = { fg = green },
    ["@number"] = { fg = peach },
    ["@boolean"] = { fg = peach },
    ["@constant"] = { fg = peach },
    ["@type"] = { fg = yellow },
    ["@property"] = { fg = lavender },
    ["@operator"] = { fg = sky },
  },
}

return M
