return {
  { "tpope/vim-dadbod", lazy = false },
  { "kristijanhusak/vim-dadbod-ui", lazy = false,
    init = function ()
      vim.g.db_ui_use_nerd_fonts = 1
      -- vim.g.db_ui_save_location = "../"
    end
  },
  { "kristijanhusak/vim-dadbod-completion", lazy = false },
}
