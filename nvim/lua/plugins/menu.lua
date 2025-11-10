return {
  "https://github.com/gisketch/menu",
  dependencies = { "nvzone/volt" },
  lazy = false,
  config = function()
    -- Set up keybinding to open your custom menu
    -- References nvim/lua/menus/main.lua
    vim.keymap.set({ "n", "v" }, "<leader>u", function()
      -- Capture visual selection range before menu opens
      local mode = vim.fn.mode()
      if mode == "v" or mode == "V" or mode == "\22" then -- visual modes
        vim.g.menu_visual_start = vim.fn.line("v")
        vim.g.menu_visual_end = vim.fn.line(".")
        print("Captured range: " .. vim.g.menu_visual_start .. "-" .. vim.g.menu_visual_end)
      else
        vim.g.menu_visual_start = nil
        vim.g.menu_visual_end = nil
        print("Normal mode - no range")
      end

      require("menu").open "main"
    end, { desc = "Open main menu" })

    vim.keymap.set("n", "<leader>l", function()
      require("menu").open "lsp"
    end, { desc = "Open LSP menu" })

    -- Optional: Right-click context menu
    vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
      vim.cmd.exec '"normal! \\<RightMouse>"'
      require("menu").open("main", { mouse = true })
    end, {})
  end,
}
