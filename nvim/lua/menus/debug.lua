-- Debug Menu (DAP)
return {
  {
    name = " Start/Continue",
    cmd = function()
      require("dap").continue()
    end,
    hl = "ExGreen",
    keybind = "c",
    rtxt = "F5",
  },
  {
    name = "󰆷 Step Over",
    cmd = function()
      require("dap").step_over()
    end,
    hl = "ExBlue",
    keybind = "n",
    rtxt = "F10",
  },
  {
    name = "󰆸 Step Into",
    cmd = function()
      require("dap").step_into()
    end,
    hl = "ExBlue",
    keybind = "i",
    rtxt = "F11",
  },
  {
    name = "󰆹 Step Out",
    cmd = function()
      require("dap").step_out()
    end,
    hl = "ExBlue",
    keybind = "o",
    rtxt = "F12",
  },
  { name = "separator" },
  {
    name = "󰃤 Toggle Breakpoint",
    cmd = function()
      require("dap").toggle_breakpoint()
    end,
    hl = "ExRed",
    keybind = "b",
    rtxt = "b",
  },
  {
    name = "󰃤 Set Conditional Breakpoint",
    cmd = function()
      require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end,
    hl = "ExRed",
    keybind = "C",
    rtxt = "C",
  },
  { name = "separator" },
  {
    name = "󰐍 Toggle DAP UI",
    cmd = function()
      require("dap-view").toggle()
    end,
    hl = "ExYellow",
    keybind = "u",
    rtxt = "u",
  },
  {
    name = " Terminate",
    cmd = function()
      require("dap").terminate()
    end,
    hl = "ExRed",
    keybind = "t",
    rtxt = "t",
  },
  {
    name = " Disconnect",
    cmd = function()
      require("dap").disconnect()
    end,
    hl = "ExRed",
    keybind = "d",
    rtxt = "d",
  },
  {
    name = " Run Last",
    cmd = function()
      require("dap").run_last()
    end,
    hl = "ExGreen",
    keybind = "l",
    rtxt = "l",
  },
}
