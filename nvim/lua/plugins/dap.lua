return {
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging Support",
    dependencies = {
      "igorlfs/nvim-dap-view", -- The UI you requested
      "NicholasMata/nvim-dap-cs", -- C# Adapter
      "theHamsta/nvim-dap-virtual-text", -- Virtual Text
    },
    -- basic keymaps for debugging
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<leader>B", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Debug: Set Conditional Breakpoint" },
      -- Toggle the UI
      { "<leader>v", function() require("dap-view").toggle() end, desc = "Debug: Toggle View" },
    },
    config = function()
      local dap = require("dap")
      local dap_view = require("dap-view")
      local dap_cs = require("dap-cs")

      -- Setup Virtual Text
      require("nvim-dap-virtual-text").setup({})

      -- Setup Icons
      local signs = {
        DapBreakpoint = { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" },
        DapBreakpointCondition = { text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" },
        DapLogPoint = { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" },
        DapStopped = { text = "", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "DapStopped" },
        DapBreakpointRejected = { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" },
      }

      for name, sign in pairs(signs) do
        vim.fn.sign_define(name, sign)
      end

      -- 1. Setup nvim-dap-view
      dap_view.setup({
        -- winbar = { show = true }, -- Enable if you want the view controls in the window bar
      })

      -- 2. Setup C# Adapter (nvim-dap-cs)
      -- This automatically finds 'netcoredbg' if installed via Mason.
      dap_cs.setup({
        netcoredbg = {
          path = "C:\\Users\\gisketch\\AppData\\Local\\nvim-data\\mason\\packages\\netcoredbg\\netcoredbg\\netcoredbg.exe"
        }
      })

      -- Add specific configuration for TestDebugApi
      dap.configurations.cs = dap.configurations.cs or {}

      table.insert(dap.configurations.cs, {
        type = "coreclr",
        name = "Attach to Process",
        request = "attach",
        processId = require('dap.utils').pick_process,
      })

      -- 3. Optional: Auto-open the View when debugging starts
      dap.listeners.after.event_initialized["dap_view_config"] = function()
        dap_view.open()
      end
      dap.listeners.before.event_terminated["dap_view_config"] = function()
        dap_view.close()
      end
      dap.listeners.before.event_exited["dap_view_config"] = function()
        dap_view.close()
      end
    end
  }
}
