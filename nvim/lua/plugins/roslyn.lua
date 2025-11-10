return {
    {
        "seblyng/roslyn.nvim",
        ft = { "cs", "razor" },
        opts = {
            filewatching = "auto",
            broad_search = false,
            lock_target = false,
            silent = false,
        },
    },
{
    "khoido2003/roslyn-filewatch.nvim",
    config = function()
      require("roslyn_filewatch").setup({})
    end,
}
}
