return {
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging Support",
    dependencies = {
      "igorlfs/nvim-dap-view", -- The UI you requested
      "NicholasMata/nvim-dap-cs", -- C# Adapter
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

      -- 1. Setup nvim-dap-view
      dap_view.setup({
        -- winbar = { show = true }, -- Enable if you want the view controls in the window bar
      })

      -- 2. Setup C# Adapter (nvim-dap-cs)
      -- This automatically finds 'netcoredbg' if installed via Mason.
      -- If installed manually, you might need to specify the path:
      -- dap_cs.setup({ netcoredbg = { path = '/usr/bin/netcoredbg' } })
      dap_cs.setup({})

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
