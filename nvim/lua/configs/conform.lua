local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    csharp = { "csharpier" },
  },

  formatters = {
    stylua = {
      command = function()
        return vim.fn.shellescape(
          vim.fn.expand "$HOME" .. "/AppData/Local/nvim-data/mason/bin/stylua.CMD"
        )
      end,
    },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
