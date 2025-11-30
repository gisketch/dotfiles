-- Testing Menu (neotest)
return {
  {
    name = " Run Nearest",
    cmd = function()
      local neotest = require("neotest")
      neotest.run.run()
      neotest.summary.open()
    end,
    hl = "ExGreen",
    keybind = "r",
    rtxt = "r",
  },
  {
    name = "󰈔 Run File",
    cmd = function()
      local neotest = require("neotest")
      neotest.run.run(vim.fn.expand("%"))
      neotest.summary.open()
    end,
    hl = "ExGreen",
    keybind = "f",
    rtxt = "f",
  },
  {
    name = "󰒍 Run Suite",
    cmd = function()
      local neotest = require("neotest")
      neotest.run.run(vim.fn.getcwd())
      neotest.summary.open()
    end,
    hl = "ExGreen",
    keybind = "a",
    rtxt = "a",
  },
  {
    name = " Debug Nearest",
    cmd = function()
      local neotest = require("neotest")
      neotest.run.run({strategy = "dap"})
      neotest.summary.open()
    end,
    hl = "ExRed",
    keybind = "d",
    rtxt = "d",
  },
  { name = "separator" },
  {
    name = "󰆷 Test Summary",
    cmd = function()
      local neotest = require("neotest")
      neotest.summary.toggle()
    end,
    hl = "ExYellow",
    keybind = "s",
    rtxt = "s",
  },
  {
    name = "󰆷 Test Output",
    cmd = function()
      local neotest = require("neotest")
      neotest.output.open({ enter = true })
    end,
    hl = "ExBlue",
    keybind = "o",
    rtxt = "o",
  },
  {
    name = "󰆷 Output Panel",
    cmd = function()
      local neotest = require("neotest")
      neotest.output_panel.toggle()
    end,
    hl = "ExYellow",
    keybind = "p",
    rtxt = "p",
  },
}
