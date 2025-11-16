-- Squirrelsong Light theme for Base46
-- Based on Squirrelsong by Artem Sapegin (https://sapegin.me/squirrelsong/)
-- Low-contrast light theme for web developers

---@type Base46Table
local M = {}

-- UI
M.base_30 = {
  white = "#3d3d3d",
  black = "#f7f3ee", -- main background
  darker_black = "#f0ebe6",
  black2 = "#ebe7e2",
  one_bg = "#ebe7e2",
  one_bg2 = "#e2ddd8",
  one_bg3 = "#d8d3ce",
  grey = "#aca397",
  grey_fg = "#9d9389",
  grey_fg2 = "#8e8379",
  light_grey = "#7f7369",
  red = "#b74e4e",
  baby_pink = "#c76868",
  pink = "#b75858",
  line = "#ebe7e2", -- subtle line color
  green = "#6d9060",
  vibrant_green = "#7da070",
  nord_blue = "#5c7a96",
  blue = "#5c7d96",
  seablue = "#5e8a9a",
  yellow = "#bf9e4e",
  sun = "#cfa856",
  purple = "#8e7faa",
  dark_purple = "#7d6f99",
  teal = "#67968b",
  orange = "#b7804e",
  cyan = "#679096",
  statusline_bg = "#ebe7e2",
  lightbg = "#e2ddd8",
  pmenu_bg = "#8e7faa",
  folder_bg = "#5c7d96",
}

-- Syntax highlighting colors based on base16
M.base_16 = {
  base00 = "#f7f3ee", -- main background
  base01 = "#ebe7e2", -- lighter background
  base02 = "#e2ddd8", -- selection background
  base03 = "#aca397", -- comments, invisibles
  base04 = "#7a7267", -- dark foreground
  base05 = "#3d3d3d", -- default foreground
  base06 = "#2d2d2d", -- light foreground
  base07 = "#1d1d1d", -- lightest foreground
  base08 = "#b74e4e", -- variables, XML tags, markup link text
  base09 = "#b7804e", -- integers, boolean, constants
  base0A = "#bf9e4e", -- classes, markup bold, search text bg
  base0B = "#6d9060", -- strings, inherited class, markup code
  base0C = "#679096", -- support, regular expressions, escape chars
  base0D = "#5c7d96", -- functions, methods, attribute IDs
  base0E = "#8e7faa", -- keywords, storage, selector, markup italic
  base0F = "#b75858", -- deprecated, opening/closing embedded lang tags
}

M.type = "light"

M.polish_hl = {
  defaults = {
    Comment = {
      italic = true,
    },
    ["@variable"] = {
      fg = M.base_30.white,
    },
  },
}

return M
