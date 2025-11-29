-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "everforest",
  theme_toggle = { "everforest", "everforest" },
  hl_override = {
    FloatBorder = { fg = "darker_black", bg = "darker_black" },
    VertSplit = { fg = "black", bg = "black" },
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

    -- DAP Highlights
    DapBreakpoint = { fg = "red" }, -- Red
    DapBreakpointLine = { bg = {"red", "darker_black", 85} },
    DapBreakpointCondition = { fg = "yellow" }, -- Yellow
    DapLogPoint = { fg = "blue" }, -- Blue
    DapStopped = { fg = "green" }, -- Green
    DapStoppedLine = { bg = {"green", "darker_black", 85} },
  },
}

M.nvdash = {
  load_on_startup = true,

  header = {
    " ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮ ",
    " │││├┤ │ │╰┐┌╯││││ ",
    " ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴ ",
    " @gisketch ",
    "                            ",
    "                            ",
    "                            ",
  },

  buttons = {
    { txt = "  Find File", keys = "Spc p f", cmd = ":lua Snacks.picker.files()" },
    { txt = "  Select Project", keys = "Spc e", cmd = ":lua _G.load_project_with_picker()" },
    { txt = "󰈭  Find Word", keys = "Spc p s", cmd = ":lua Snacks.picker.grep()" },
    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

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
        local ok, cur_file = pcall(api.nvim_buf_get_name, cur_buf)
        if not ok or not cur_file then
          return txt("%=", "Fill")
        end
        local opts = require("nvconfig").ui.tabufline

        -- Normalize path for Windows (lowercase, forward slashes)
        local function normalize_path(path)
          if path == "" then
            return ""
          end
          local normalized = vim.fn.fnamemodify(path, ":p"):gsub("\\", "/")
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

        -- Helper to find buffer number by path
        local function find_buf_by_path(path)
          local normalized_path = normalize_path(path)
          for _, bufnr in ipairs(api.nvim_list_bufs()) do
            if api.nvim_buf_is_valid(bufnr) and api.nvim_buf_is_loaded(bufnr) then
              local ok, buf_path = pcall(api.nvim_buf_get_name, bufnr)
              if ok and buf_path then
                buf_path = normalize_path(buf_path)
                if buf_path == normalized_path then
                  return bufnr
                end
              end
            end
          end
          return nil
        end

        -- Helper to create a tab entry
        local function create_tab(path, index, is_active, bufnr)
          local tbHlName = "BufO" .. (is_active and "n" or "ff")

          -- Check if buffer is modified
          local is_modified = false
          if bufnr and api.nvim_buf_is_valid(bufnr) then
            is_modified = api.nvim_get_option_value("modified", { buf = bufnr })
          end

          -- Get file icon
          local name = filename(path)
          local icon = "󰈚 "
          local icon_hl = new_hl("DevIconDefault", tbHlName)

          if name then
            local devicon, devicon_hl = require("nvim-web-devicons").get_icon(name)
            if devicon then
              icon = " " .. devicon .. " "
              icon_hl = new_hl(devicon_hl, tbHlName)
            end
          end

          -- Add modified indicator
          local modified_indicator = ""
          if is_modified then
            local mod_hl = is_active and "BufOnModified" or "BufOffModified"
            modified_indicator = txt(" ", mod_hl)
          end
          -- Calculate padding
          local w = opts.bufwidth
          local num_width = index and 2 or 0 -- " 1 " takes 3 chars
          local mod_width = is_modified and 2 or 0
          local pad = math.floor((w - #name - 3 - num_width - mod_width) / 2)
          pad = pad <= 0 and 1 or pad

          -- Truncate long names
          local maxname_len = w - 3 - num_width - mod_width
          name = string.sub(name, 1, maxname_len - 2) .. (#name > maxname_len and ".." or "")

          -- Build the tab
          local content = string.rep(" ", pad - 1)
            .. icon_hl
            .. icon
            .. modified_indicator
            .. txt(name, tbHlName)
            .. string.rep(" ", pad - 1)

          if index then
            -- Grapple file: add index number and make it clickable
            local index_num = txt(" " .. index .. " ", tbHlName)
            content = btn(content .. index_num, nil, "GrappleSelect", index)
          else
            -- Non-Grapple file: just make the whole thing clickable to go to buffer
            content = btn(content, nil, "GoToBuf", cur_buf)
          end

          content = txt(content, tbHlName)
          return content
        end

        local result = {}

        -- Check if current file is in Grapple tags
        local is_in_grapple = false
        for _, tag in ipairs(tags) do
          if normalize_path(tag.path) == cur_file then
            is_in_grapple = true
            break
          end
        end

        -- If current file is NOT in Grapple, show it first (no number)
        if not is_in_grapple and cur_file ~= "" then
          table.insert(result, create_tab(cur_file, nil, true, cur_buf))
        end

        -- Show all Grapple files with numbers
        for i, tag in ipairs(tags) do
          local tag_path = normalize_path(tag.path)
          local is_current = tag_path == cur_file
          local tag_bufnr = find_buf_by_path(tag.path)
          table.insert(result, create_tab(tag.path, i, is_current, tag_bufnr))
        end

        return table.concat(result) .. txt("%=", "Fill")
      end,
    },
  },
  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "f", "git", "%=", "lsp_msg", "%=", "lsp", "cwd", "spc", "abc", "spc" },
    modules = {
      spc = " ",
      abc = function()
        local recording_register = vim.fn.reg_recording()
        if recording_register ~= "" then
          return "󰑋 @" .. recording_register
        end
        return require("triforce.lualine").streak()
      end,
      f = " %F ",
    },
  },
}

return M
