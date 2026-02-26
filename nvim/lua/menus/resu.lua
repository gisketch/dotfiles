-- Resu.nvim AI review menu
return {
  {
    name = "󰄱 Toggle Review Panel",
    cmd = function()
      vim.cmd "ResuToggle"
    end,
    keybind = "t",
    rtxt = "t",
  },
  { name = "separator" },
  {
    name = "󰄬 Accept Current File",
    hl = "ExGreen",
    cmd = function()
      vim.cmd "ResuAccept"
    end,
    keybind = "a",
    rtxt = "a",
  },
  {
    name = "󰜺 Decline Current File",
    hl = "ExRed",
    cmd = function()
      vim.cmd "ResuDecline"
    end,
    keybind = "d",
    rtxt = "d",
  },
  { name = "separator" },
  {
    name = "󰄮 Accept All Changes",
    hl = "ExGreen",
    cmd = function()
      vim.cmd "ResuAcceptAll"
    end,
    keybind = "A",
    rtxt = "A",
  },
  {
    name = "󰛌 Decline All Changes",
    hl = "ExRed",
    cmd = function()
      vim.cmd "ResuDeclineAll"
    end,
    keybind = "D",
    rtxt = "D",
  },
  { name = "separator" },
  {
    name = "󰑐 Refresh",
    cmd = function()
      vim.cmd "ResuRefresh"
    end,
    keybind = "r",
    rtxt = "r",
  },
  {
    name = "󰄯 Reset State",
    cmd = function()
      vim.cmd "ResuReset"
    end,
    keybind = "x",
    rtxt = "x",
  },
}
