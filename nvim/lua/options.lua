local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"

o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- Terminal shell configuration (Windows only)
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    vim.opt.shell = 'powershell.exe'
    vim.opt.shellcmdflag = '-Command'
    vim.opt.shellquote = ''
    vim.opt.shellxquote = ''
end

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Questionable
vim.opt.ignorecase = true

-- Indentation
-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true

-- Line wrapping
vim.opt.wrap = false

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false

-- Cross-platform undo directory
local undodir
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    -- Windows
    undodir = vim.fn.expand('$LOCALAPPDATA/nvim-undo')
else
    -- macOS and Linux
    undodir = vim.fn.expand('~/.vim/undodir')
end

vim.fn.mkdir(undodir, 'p')
vim.opt.undodir = undodir
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.fillchars = 'eob: '

-- Miscellaneous
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

if vim.g.neovide then
    vim.o.guifont = "JetBrainsMonoNL Nerd Font Propo:h11"
    -- vim.g.neovide_scale_factor = 1.4
    vim.opt.linespace = 5

    -- Neovide title colors are now managed by the theme system
    -- See lua/plugins/colorscheme.lua for theme-specific color configurations

    vim.g.neovide_padding_top = 2
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 2

    -- vim.g.neovide_floating_corner_radius = 0.5

    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 5
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 1

    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_remember_window_size = true

    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_trail_size = 0.05

    vim.g.neovide_scroll_animation_length = 0.05
end

