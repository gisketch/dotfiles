-- Custom submenu for nested actions
return {
  {
    name = "Reload Config",
    cmd = function()
      vim.cmd("source $MYVIMRC")
      vim.notify("Config reloaded!")
    end,
    rtxt = "rc",
  },

  {
    name = "Show Diagnostics",
    cmd = vim.diagnostic.open_float,
    rtxt = "sd",
  },

  {
    name = "Toggle Spellcheck",
    cmd = function()
      vim.wo.spell = not vim.wo.spell
      vim.notify("Spellcheck: " .. (vim.wo.spell and "ON" or "OFF"))
    end,
  },
}
