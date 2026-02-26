return {
  "koushikxd/resu.nvim",
  lazy = false,
  dependencies = {
    "sindrets/diffview.nvim",
  },
  config = function()
    require("diffview").setup({
      view = {
        default = { layout = "diff2_vertical" },
        merge_tool = { layout = "diff3_vertical" },
      },
    })
    require("resu").setup()
  end,
}
