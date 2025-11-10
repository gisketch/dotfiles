-- Main custom menu
return {
  {
    name = " Copy File Path",
    cmd = function()
      local path = vim.fn.expand "%:p"
      vim.fn.setreg("+", path)
      vim.notify("Copied path: " .. path)
    end,
    rtxt = "c",
  },

  {
    name = " Copy All",
    cmd = function()
      vim.cmd "%y+"
      vim.notify "Copied entire file to clipboard"
    end,
    rtxt = "Y",
  },

  { name = "separator" },

  {
    name = "󰊢 Git Operations",
    hl = "ExGreen",
    items = "git",
    keybind = "g",
    rtxt = "g",
  },
  {
    name = "󰊢 Git Signs",
    hl = "ExPurple",
    items = "gitsigns",
    keybind = "h",
    rtxt = "h",
  },
  {
    name = "󰀄 Sessions",
    hl = "ExYellow",
    items = "sessions",
    keybind = "s",
    rtxt = "s",
  },
  {
    name = "󰛡 Utilities",
    hl = "ExBlue",
    items = "utils",
    keybind = "t",
    rtxt = "t",
  },
}
