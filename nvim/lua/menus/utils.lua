return {
  {
    name = "󰌘 Restart LSP Server",
    cmd = function()
      vim.cmd "LspRestart"
    end,
    keybind = "r",
    rtxt = "r",
  },
  {
    name = "󰎟 Notifications",
    cmd = function()
      vim.cmd "Noice telescope"
    end,
    keybind = "n",
    rtxt = "n",
  },
  {
    name = " Clear Buffers",
    cmd = function()
      vim.cmd "%bd|e#"
    end,
    keybind = "c",
    rtxt = "c",
  },
  {
    name = " Command History",
    cmd = function()
      vim.cmd "lua Snacks.picker.command_history()"
    end,
    keybind = "h",
    rtxt = "h",
  },
  {
    name = "  Toggle Transparency",
    cmd = function()
      local nvconfig = require "nvconfig"
      nvconfig.base46.transparency = not nvconfig.base46.transparency
      require("base46").load_all_highlights()
      vim.notify("Transparency: " .. (nvconfig.base46.transparency and "ON" or "OFF"))
    end,
    keybind = "T",
    rtxt = "T",
  },
}
