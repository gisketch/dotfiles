-- Main custom menu
return {
  {
    name = " Copy File Path",
    cmd = function()
      local path = vim.fn.expand "%:p"
      vim.fn.setreg("+", path)
      vim.notify("Copied path: " .. path)
    end,
    rtxt = "p",
  },
  {
    name = " Copy All",
    cmd = function()
      vim.cmd "%y+"
      vim.notify "Copied entire file to clipboard"
    end,
    rtxt = "Y",
  },
  {
    name = "󱇜 Split Vertical",
    cmd = function()
      vim.cmd "vsplit"
    end,
    rtxt = "v",
  },
  {
    name = "󱇘 Split Horizontal",
    cmd = function()
      vim.cmd "split"
    end,
    rtxt = "b",
  },
  { name = "separator" },
  {
    name = " Copy References",
    hl = "Boolean",
    items = "copy",
    keybind = "c",
    rtxt = "c",
  },
  {
    name = "󰊢 Git Operations",
    hl = "ExGreen",
    items = "git",
    keybind = "g",
    rtxt = "g",
  },
  {
    name = "󰊢 Git Signs",
    hl = "Keyword",
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
  {
    name = "󰈔 LSP",
    hl = "ExRed",
    items = "lsp",
    keybind = "l",
    rtxt = "l",
  },
}
