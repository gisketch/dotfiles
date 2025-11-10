-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",
  hl_override = {
    FloatBorder = { fg = "black", bg = "black" },
  },
  hl_add = {
    FlashMatch = { bg = "NONE", fg = { "yellow", "black", 50 } },
    FlashCurrent = { bg = "NONE", fg = "yellow" },

    SnacksPickerInput = { bg = "black2" },
    SnacksPickerPreview = { bg = "darker_black" },
    SnacksPickerList = { bg = "black" },
    SnacksPickerInputBorder = { bg = "black2", fg = "black2" },
    SnacksPickerPreviewBorder = { bg = "darker_black", fg = "darker_black" },
    SnacksPickerListBorder = { bg = "black", fg = "black" },
    SnacksPickerInputTitle = { bg = "green", fg = "black" },
    SnacksPickerPreviewTitle = { bg = "blue", fg = "black" },
    SnacksInputIcon = { bg = "darker_black", fg = "green" },
    SnacksInputTitle = { bg = "green", fg = "darker_black" },
    SnacksInputNormal = { bg = "darker_black" },
    SnacksInputBorder = { bg = "darker_black", fg = "darker_black" },
    SnacksInputPrompt = { bg = "darker_black" },
    SnacksIndent = { fg = "black3" },
    SnacksIndentScope = { fg = "grey" },
    SnacksNotifierTitleWarn = { fg = "yellow", bg = "darker_black" },
    SnacksNotifierBorderWarn = { bg = "darker_black", fg = "darker_black" },
    SnacksNotifierBorderInfo = { bg = "darker_black", fg = "darker_black" },
    SnacksNotifierBorderDebug = { bg = "darker_black", fg = "darker_black" },
    SnacksNotifierBorderError = { bg = "darker_black", fg = "darker_black" },
    SnacksNotifierBorderTrace = { bg = "darker_black", fg = "darker_black" },
    SnacksNotifierWarn = { bg = "darker_black" },
    SnacksNotifierInfo = { bg = "darker_black" },
    SnacksNotifierDebug = { bg = "darker_black" },
    SnacksNotifierError = { bg = "darker_black" },
    SnacksNotifierTrace = { bg = "darker_black" },
    NoiceCmdlinePopupBorder = { bg = "darker_black", fg = "darker_black" },
  },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  cmp = {
    style = "flat_dark",
  },
  tabufline = {
    lazyload = false,
    modules = {
      buffers = function()
        local api = vim.api
        local grapple_ok, grapple = pcall(require, "grapple")

        -- Helper function for txt (needed early for Fill)
        local function txt(str, hl)
          return "%#Tb" .. hl .. "#" .. (str or "")
        end

        if not grapple_ok then
          return txt("%=", "Fill")
        end

        local tags = grapple.tags()
        if not tags or #tags == 0 then
          return txt("%=", "Fill")
        end

        local cur_buf = api.nvim_get_current_buf()
        local cur_file = api.nvim_buf_get_name(cur_buf)
        local opts = require("nvconfig").ui.tabufline

        -- Normalize path for Windows (lowercase, forward slashes)
        local function normalize_path(path)
          if path == "" then
            return ""
          end
          local normalized = vim.fn.fnamemodify(path, ":p"):gsub("\\", "/"):lower()
          return normalized
        end

        cur_file = normalize_path(cur_file)

        -- Helper functions from nvchad utils
        local function btn(str, hl, func, arg)
          str = hl and txt(str, hl) or str
          arg = arg or ""
          return "%" .. arg .. "@Tb" .. func .. "@" .. str .. "%X"
        end

        local function filename(str)
          return str:match "([^/\\]+)[/\\]*$"
        end

        local function new_hl(group1, group2)
          local get_hl = api.nvim_get_hl
          local fg = get_hl(0, { name = group1 }).fg
          local bg = get_hl(0, { name = "Tb" .. group2 }).bg
          api.nvim_set_hl(0, group1 .. group2, { fg = fg, bg = bg })
          return "%#" .. group1 .. group2 .. "#"
        end

        -- Create vim function for clicking grapple tags (only once)
        if vim.fn.exists "*TbGrappleSelect" == 0 then
          vim.cmd [[
						function! TbGrappleSelect(index,b,c,d)
							execute 'Grapple select index=' . a:index
						endfunction
					]]
        end

        local result = {}

        for i, tag in ipairs(tags) do
          -- Normalize both paths for comparison
          local tag_path = normalize_path(tag.path)
          local is_current = tag_path == cur_file
          local tbHlName = "BufO" .. (is_current and "n" or "ff")

          -- Get file icon
          local name = filename(tag.path)
          local icon = "󰈚 "
          local icon_hl = new_hl("DevIconDefault", tbHlName)

          if name then
            local devicon, devicon_hl = require("nvim-web-devicons").get_icon(name)
            if devicon then
              icon = " " .. devicon .. " "
              icon_hl = new_hl(devicon_hl, tbHlName)
            end
          end

          -- Calculate padding
          local w = opts.bufwidth
          local pad = math.floor((w - #name - 4) / 2)
          pad = pad <= 0 and 1 or pad

          -- Truncate long names
          local maxname_len = w - 4
          name = string.sub(name, 1, maxname_len - 2) .. (#name > maxname_len and ".." or "")
          name = txt(name, tbHlName)

          -- Build the tab with index number on the right
          local content = string.rep(" ", pad - 1) .. icon_hl .. icon .. name .. string.rep(" ", pad - 1)
          local index_num = txt(" " .. i .. " ", tbHlName)

          content = btn(content .. index_num, nil, "GrappleSelect", i)
          content = txt(content, tbHlName)

          table.insert(result, content)
        end

        return table.concat(result) .. txt("%=", "Fill")
      end,
    },
  },
  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "f", "git", "%=", "lsp_msg", "%=", "xyz", "spc", "lsp", "cwd", "spc", "abc" },
    modules = {
      spc = " ",
      xyz = function()
        return require("triforce.lualine").achievements()
      end,
      abc = function()
        return require("triforce.lualine").level()
      end,
      f = " %F ",
    },
  },
}

return M
