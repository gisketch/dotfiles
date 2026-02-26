local map = vim.keymap.set

-- NVChadMappings
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })

map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map({ "n", "x" }, "<leader>f", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })


-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- My custom mappings

map("n", ";", ":", { desc = "CMD enter command mode" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "n" }, "<leader><leader>", "<cmd> source <cr>")

-- Movement and editing
map("v", "<S-Down>", ":m '>+1<CR>gv=gv")
map("v", "<S-Up>", ":m '<-2<CR>gv=gv")
map("n", "J", "mzJ`z")

-- Start/End of line
map({ "n", "v" }, "<leader><Left>", "^")
map({ "n", "v" }, "<leader><Right>", "$")

-- Navigation
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Clipboard operations
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- Insert mode escape
map("i", "<C-c>", "<Esc>")

-- Location list navigation
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

-- Testing Menu
map("n", "<leader>x", function()
  require("menu").open "testing"
end, { desc = "Open testing menu" })

-- Paste
map("", "<C-S-v>", '"+p', { noremap = true, silent = true })
map("i", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
map("v", "<C-S-v>", '"+p', { noremap = true, silent = true })
map("t", "<C-S-v>", '<C-\\><C-o>"+p', { noremap = true, silent = true })

-- Split management
map("n", "<M-v>", ":vsplit<CR>", { noremap = true, silent = true })
map("n", "<M-s>", ":split<CR>", { noremap = true, silent = true })
map("t", "<M-v>", "<C-\\><C-n>:vsplit<CR>", { noremap = true, silent = true })
map("t", "<M-s>", "<C-\\><C-n>:split<CR>", { noremap = true, silent = true })
map("t", "<D-v>", '<C-\\><C-o>"+p', { noremap = true, silent = true })

-- Window navigation
map("n", "<C-f>", "<C-w>w", { noremap = true, silent = true })
map("n", "<C-Left>", "<cmd>lua require('tmux').move_left()<CR>", { noremap = true, silent = true })
map("n", "<C-Down>", "<cmd>lua require('tmux').move_bottom()<CR>", { noremap = true, silent = true })
map("n", "<C-Up>", "<cmd>lua require('tmux').move_top()<CR>", { noremap = true, silent = true })
map("n", "<C-Right>", "<cmd>lua require('tmux').move_right()<CR>", { noremap = true, silent = true })
map("n", "<C-,>", "<cmd>lua require('tmux').previous_window()<CR>", { noremap = true, silent = true })
map("n", "<C-.>", "<cmd>lua require('tmux').next_window()<CR>", { noremap = true, silent = true })
map("t", "<C-f>", [[<C-\><C-n><C-w>w]], { noremap = true, silent = true })
map("t", "<C-Left>", [[<C-\><C-n><cmd>lua require('tmux').move_left()<CR>]], { noremap = true, silent = true })
map("t", "<C-Down>", [[<C-\><C-n><cmd>lua require('tmux').move_bottom()<CR>]], { noremap = true, silent = true })
map("t", "<C-Up>", [[<C-\><C-n><cmd>lua require('tmux').move_top()<CR>]], { noremap = true, silent = true })
map("t", "<C-Right>", [[<C-\><C-n><cmd>lua require('tmux').move_right()<CR>]], { noremap = true, silent = true })
map("t", "<C-,>", [[<C-\><C-n><cmd>lua require('tmux').previous_window()<CR>]], { noremap = true, silent = true })
map("t", "<C-.>", [[<C-\><C-n><cmd>lua require('tmux').next_window()<CR>]], { noremap = true, silent = true })

-- Window resizing
map("n", "<C-S-Left>", "<cmd>lua require('tmux').resize_left()<CR>", { noremap = true, silent = true })
map("n", "<C-S-Down>", "<cmd>lua require('tmux').resize_bottom()<CR>", { noremap = true, silent = true })
map("n", "<C-S-Up>", "<cmd>lua require('tmux').resize_top()<CR>", { noremap = true, silent = true })
map("n", "<C-S-Right>", "<cmd>lua require('tmux').resize_right()<CR>", { noremap = true, silent = true })

-- Tab management
map("n", "<C-t>", ":tabnew<CR>", { noremap = true, silent = true, desc = "new tab" })
map("n", "<C-w>", ":tabclose<CR>", { noremap = true, silent = true, nowait = true, desc = "close tab" })
map("n", "<C-Tab>", ":tabnext<CR>", { noremap = true, silent = true, desc = "next tab" })
map("n", "<C-S-Tab>", ":tabprevious<CR>", { noremap = true, silent = true, desc = "previous tab" })

map("n", "<leader>e", function()
  _G.load_project_with_picker()
end, { desc = "Load Project" })
