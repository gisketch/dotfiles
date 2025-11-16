return {
    "rachartier/tiny-code-action.nvim",
    lazy = false,
    dependencies = {
        {"nvim-lua/plenary.nvim"},
        {
          "folke/snacks.nvim",
          opts = {
            terminal = {},
          }
        }
    },
    event = "LspAttach",
    opts = {
        picker = "snacks"
    },
}
