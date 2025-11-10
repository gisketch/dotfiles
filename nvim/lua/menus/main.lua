-- Main custom menu
return {
  {
    name = "Copy File Path",
    cmd = function()
      local path = vim.fn.expand "%:p"
      vim.fn.setreg("+", path)
      vim.notify("Copied: " .. path)
    end,
    rtxt = "c",
  },
  { name = "separator" },
  {
    name = "󰊢 Git Operations",
    hl = "ExGreen",
    items = "git",
    keybind = "g",
  },
  {
    name = "󰊢 Sessions",
    hl = "ExYellow",
    items = "sessions",
    keybind = "s",
  },
  {
    name = "󰊢 Utilities",
    hl = "ExBlue",
    items = "utils",
    keybind = "t",
  },
}
