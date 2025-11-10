return {
    "https://github.com/gisketch/menu",
    dependencies = { "nvzone/volt" },
    lazy = false,
    config = function()
        -- Set up keybinding to open your custom menu
        -- References nvim/lua/menus/main.lua
        vim.keymap.set("n", "<leader>u", function()
            require("menu").open("main")
        end, { desc = "Open main menu" })

        -- Optional: Right-click context menu
        vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
            vim.cmd.exec '"normal! \\<RightMouse>"'
            require("menu").open("main", { mouse = true })
        end, {})
    end,
}
