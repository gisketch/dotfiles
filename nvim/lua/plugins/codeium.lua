return {
  "Exafunction/windsurf.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("codeium").setup {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        filetypes = {},
        default_filetype_enabled = true,
        -- How long to wait (in ms) before requesting completions after typing stops.
        idle_delay = 15,
        map_keys = true,
        accept_fallback = nil,
        key_bindings = {
          accept = "<C-a>",
          accept_word = false,
          accept_line = false,
          clear = false,
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
    }

    -- Disable Codeium in prompt and special buffers
    vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
      callback = function(args)
        local bufnr = args.buf
        local buftype = vim.bo[bufnr].buftype
        local filetype = vim.bo[bufnr].filetype

        -- Disable for prompt, nofile, and other special buffer types
        if buftype == "prompt" or buftype == "nofile" or filetype == "TelescopePrompt" then
          vim.b[bufnr].codeium_enabled = false
        end
      end,
    })
  end,
}
