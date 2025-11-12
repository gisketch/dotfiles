return {
  -- Add nvim-treesitter first
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "http", "json" }, -- kulala requires http parser
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },

  -- kulala.nvim
  {
    "mistweaverco/kulala.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send request" },
      { "<leader>Ra", "<cmd>lua require('kulala').run_all()<cr>", desc = "Send all requests" },
      { "<leader>Rb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
    },
    ft = {"http", "rest"},
    opts = {
      default_view = "body",
      default_env = "dev",
      debug = false,
        ui = {
            display_mode = "split",
            split_direction = "horizontal",
            win_opts = { bo = {}, wo = {} }, ---@type kulala.ui.win_config
            default_view = "body", ---@type "body"|"headers"|"headers_body"|"verbose"|fun(response: Response)
            -- enable winbar
            winbar = false,
            default_winbar_panes = { "body", "headers", "headers_body", "verbose" },
            -- enable/disable variable info text
            -- this will show the variable name and value as float
            -- possible values: false, "float"
            show_variable_info_text = false,
            -- icons position: "signcolumn"|"on_request"|"above_request"|"below_request" or nil to disable
            show_icons = "on_request",
            -- default icons
            icons = {
              inlay = {
                loading = "⏳",
                done = "✅",
                error = "❌",
              },
              lualine = "🐼",
              textHighlight = "WarningMsg", -- highlight group for request elapsed time
            },
        },
    },
    config = function(_, opts)
      require('kulala').setup(opts)
    end,
  },
}
