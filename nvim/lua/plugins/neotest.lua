return {
  {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "issafalcon/neotest-dotnet",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-dotnet")({
            dap = { adapter_name = "coreclr", args = { justMyCode = false } },
          }),
        },
        icons = {
          expanded = "",
          child_prefix = "",
          child_indent = "",
          final_child_prefix = "",
          non_collapsible = "",
          collapsed = "",

          passed = "",
          running = "",
          failed = "",
          unknown = "",
        },
      })

      -- Custom signs with line highlighting
      local signs = {
        NeotestPassed = { text = "", texthl = "NeotestPassed", linehl = "NeotestPassedLine" },
        NeotestFailed = { text = "", texthl = "NeotestFailed", linehl = "NeotestFailedLine" },
        NeotestRunning = { text = "", texthl = "NeotestRunning", linehl = "NeotestRunningLine" },
        NeotestSkipped = { text = "", texthl = "NeotestSkipped", linehl = "NeotestSkippedLine" },
      }

      for name, sign in pairs(signs) do
        vim.fn.sign_define(name, sign)
      end

      -- Patch neotest-dotnet to handle spaces in project paths
      local dot_utils = require("neotest-dotnet.utils.build-spec-utils")
      local original_create_single_spec = dot_utils.create_single_spec

      dot_utils.create_single_spec = function(position, proj_root, filter_arg, dotnet_additional_args)
         -- Quote the project root path if it isn't already
         local quoted_root = proj_root
         if not proj_root:match('^".*"$') then
             quoted_root = '"' .. proj_root .. '"'
         end

         -- Call the original function but let's manually reconstruct the command
         -- because the original function constructs it internally.
         -- Since we can't easily inject the quoted path into the original function without
         -- re-implementing it, we will re-implement the necessary part here.

         -- RE-IMPLEMENTATION OF create_single_spec
         local async = require("neotest.async")
         local logger = require("neotest.logging")

         local results_path = async.fn.tempname() .. ".trx"
         filter_arg = filter_arg or ""

         local command = {
            "dotnet",
            "test",
            quoted_root, -- This is the fix
            filter_arg,
            "--results-directory",
            vim.fn.fnamemodify(results_path, ":h"),
            "--logger",
            '"trx;logfilename=' .. vim.fn.fnamemodify(results_path, ":t:h") .. '"',
         }

         if dotnet_additional_args then
            for _, arg in ipairs(dotnet_additional_args) do
               table.insert(command, arg)
            end
         end

         if vim.g.neotest_dotnet_runsettings_path then
            table.insert(command, "--settings")
            table.insert(command, vim.g.neotest_dotnet_runsettings_path)
         end

         local command_string = table.concat(command, " ")
         logger.debug("neotest-dotnet (patched): Running tests using command: " .. command_string)

         return {
            command = command_string,
            context = {
               results_path = results_path,
               file = position.path,
               id = position.id,
            },
         }
      end
    end,
  },
}
