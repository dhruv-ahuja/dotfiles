-- Core Neovim Options
-- Migrated from init.vim with additional sensible defaults

local opt = vim.opt

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

opt.undofile = true         -- Persistent undo

-- VS Code owns display, scrolling, mouse, and window layout when Neovim is
-- embedded by VSCode-Neovim. Keep these UI options native-Neovim-only.
if not vim.g.vscode then
  opt.number = true
  opt.relativenumber = true
  opt.termguicolors = true
  opt.cursorline = true
  opt.signcolumn = "yes"
  opt.mouse = "a"
  opt.scrolloff = 8
  opt.sidescrolloff = 8
  opt.splitright = true
  opt.splitbelow = true
end
