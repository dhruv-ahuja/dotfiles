-- Core Neovim Options
-- Migrated from init.vim with additional sensible defaults

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Clipboard integration
opt.clipboard = "unnamedplus"

-- Additional sensible defaults
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 2          -- Indent size
opt.tabstop = 2             -- Tab size
opt.smartindent = true      -- Smart autoindenting

opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.cursorline = true       -- Highlight current line
opt.signcolumn = "yes"      -- Always show sign column

opt.mouse = "a"             -- Enable mouse support
opt.undofile = true         -- Persistent undo
opt.scrolloff = 8           -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8       -- Keep 8 columns left/right of cursor

-- Split behavior
opt.splitright = true       -- Vertical splits go right
opt.splitbelow = true       -- Horizontal splits go below
