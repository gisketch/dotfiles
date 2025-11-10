-- LSP Menu
return {
  {
    name = "󰒭 Go to Declaration",
    cmd = function()
      vim.lsp.buf.declaration()
    end,
    keybind = "D",
    rtxt = "D",
  },

  {
    name = "󰈔 Go to Definition",
    cmd = function()
      vim.lsp.buf.definition()
    end,
    keybind = "d",
    rtxt = "d",
  },

  {
    name = "󰘧 Hover Documentation",
    cmd = function()
      vim.lsp.buf.hover { border = "rounded" }
    end,
    keybind = "K",
    rtxt = "K",
  },

  {
    name = "󰌹 Go to Implementation",
    cmd = function()
      vim.lsp.buf.implementation()
    end,
    keybind = "m",
    rtxt = "m",
  },

  {
    name = "󰘡 Signature Help",
    cmd = function()
      vim.lsp.buf.signature_help()
    end,
    keybind = "k",
    rtxt = "k",
  },

  {
    name = " Show Diagnostics",
    cmd = function()
      Snacks.picker.diagnostics()
    end,
    keybind = "H",
    rtxt = "H",
  },

  {
    name = " Show Diagnostics (buffer)",
    cmd = function()
      Snacks.picker.diagnostics_buffer()
    end,
    keybind = "h",
    rtxt = "h",
  },

  { name = "separator" },

  {
    name = "󰜞 Type Definition",
    cmd = function()
      vim.lsp.buf.type_definition()
    end,
    keybind = "t",
    rtxt = "t",
  },

  {
    name = "󰑕 Rename Symbol",
    cmd = function()
      vim.lsp.buf.rename()
    end,
    keybind = "r",
    rtxt = "r",
  },
}
