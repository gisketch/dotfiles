return {
  {
    name = "󰆓 Save Session",
    cmd = function()
      _G.save_session_with_input()
    end,
    keybind = "s",
    rtxt = "s",
  },

  { name = "separator" },

  {
    name = "󰆴 Delete Session",
    cmd = function()
      _G.delete_session_with_picker()
    end,
    hl = "ExRed",
    keybind = "d",
    rtxt = "d",
  },
}
