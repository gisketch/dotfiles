-- Git operations menu using fugitive functions
local function open_git_in_float(cmd, title)
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = title,
    title_pos = "center",
  })

  vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code, _)
      if exit_code == 0 then
        vim.defer_fn(function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end, 200)
      end
    end,
  })

  vim.cmd("startinsert")
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
end

return {
  {
    name = "󰊢 Git Status",
    cmd = function()
      vim.cmd("Git")
      local fugitive_buf = vim.api.nvim_get_current_buf()
      local fugitive_win = vim.api.nvim_get_current_win()

      local width = math.floor(vim.o.columns * 0.8)
      local height = math.floor(vim.o.lines * 0.8)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      local float_win = vim.api.nvim_open_win(fugitive_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = " 󰊢 Git Status ",
        title_pos = "center",
      })

      vim.api.nvim_win_close(fugitive_win, false)
      vim.wo[float_win].winblend = 0
      vim.api.nvim_buf_set_keymap(fugitive_buf, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
    end,
    keybind = "s",
    rtxt = "gs",
  },

  {
    name = " Git Commit",
    cmd = function()
      vim.cmd("Git commit")
      local commit_buf = vim.api.nvim_get_current_buf()
      local commit_win = vim.api.nvim_get_current_win()

      local width = math.floor(vim.o.columns * 0.7)
      local height = math.floor(vim.o.lines * 0.8)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      local float_win = vim.api.nvim_open_win(commit_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = "  Git Commit ",
        title_pos = "center",
      })

      vim.api.nvim_win_close(commit_win, false)
      vim.wo[float_win].winblend = 0
      vim.api.nvim_buf_set_keymap(commit_buf, "n", "q", "<cmd>cq<cr>", { noremap = true, silent = true })
    end,
    keybind = "c",
    rtxt = "m",
  },

  {
    name = "󰄾 Git Diff",
    cmd = "Gdiffsplit",
    keybind = "d",
    rtxt = "d",
  },

  { name = "separator" },

  {
    name = "󰕙 Push",
    cmd = function()
      open_git_in_float("git push", " 󰕙 Push ")
    end,
    keybind = "p",
    rtxt = "p"
  },

  {
    name = "󰳙 Pull",
    cmd = function()
      open_git_in_float("git pull", " 󰳙 Pull ")
    end,
    keybind = "l",
    rtxt = "l",
  },

  {
    name = "󰣖 Fetch",
    cmd = function()
      open_git_in_float("git fetch", " 󰣖 Fetch ")
    end,
    keybind = "f",
    rtxt = "f",
  },

  { name = "separator" },

  {
    name = "󰋓 Stash",
    cmd = function()
      open_git_in_float("git stash", " 󰋓 Stash ")
    end,
    keybind = "t",
    rtxt = "t",
  },

  {
    name = "󰆍 Log",
    cmd = "Git log",
    keybind = "l",
    rtxt = "l",
  },

  {
    name = " Amend Commit",
    cmd = function()
      vim.cmd("Git commit --amend")
      local commit_buf = vim.api.nvim_get_current_buf()
      local commit_win = vim.api.nvim_get_current_win()

      local width = math.floor(vim.o.columns * 0.7)
      local height = math.floor(vim.o.lines * 0.8)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      local float_win = vim.api.nvim_open_win(commit_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = "  Git Amend ",
        title_pos = "center",
      })

      vim.api.nvim_win_close(commit_win, false)
      vim.wo[float_win].winblend = 0
      vim.api.nvim_buf_set_keymap(commit_buf, "n", "q", "<cmd>cq<cr>", { noremap = true, silent = true })
    end,
    keybind = "a",
    rtxt = "a",
  },
}
