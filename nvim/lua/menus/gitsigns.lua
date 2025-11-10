local gitsigns = require("gitsigns")

return {
  {
    name = "󰊢 Stage Hunk",
    cmd = function()
      gitsigns.stage_hunk()
    end,
    keybind = "s",
    rtxt = "s",
  },

  {
    name = "󰛔 Reset Hunk",
    cmd = function()
      gitsigns.reset_hunk()
    end,
    keybind = "r",
    rtxt = "r",
  },

  {
    name = "󰊢 Stage Buffer",
    cmd = function()
      gitsigns.stage_buffer()
    end,
    keybind = "b",
    rtxt = "b",
  },

  {
    name = "󰜺 Undo Stage Hunk",
    cmd = function()
      gitsigns.undo_stage_hunk()
    end,
    keybind = "u",
    rtxt = "u",
  },

  {
    name = "󰛔 Reset Buffer",
    cmd = function()
      gitsigns.reset_buffer()
    end,
    keybind = "B",
    rtxt = "B",
  },

  {
    name = "󰍉 Preview Hunk",
    cmd = function()
      gitsigns.preview_hunk()
    end,
    keybind = "p",
    rtxt = "p",
  },

  {
    name = "󰈬 Blame Line",
    cmd = function()
      gitsigns.blame_line { full = true }
    end,
    keybind = "l",
    rtxt = "l",
  },

  {
    name = "󰔀 Diff This",
    cmd = function()
      gitsigns.diffthis()
    end,
    keybind = "d",
    rtxt = "d",
  },

  {
    name = "󰔀 Diff This ~",
    cmd = function()
      gitsigns.diffthis('~')
    end,
    keybind = "D",
    rtxt = "D",
  },

  {
    name = "󰔡 Toggle Line Blame",
    cmd = function()
      gitsigns.toggle_current_line_blame()
    end,
    keybind = "t",
    rtxt = "t",
  },

  {
    name = "󰍵 Toggle Deleted",
    cmd = function()
      gitsigns.toggle_deleted()
    end,
    keybind = "x",
    rtxt = "x",
  },
}
