-- Lazy.nvim plugin manager configuration
-- Plugins for markdown note-taking with inline rendering

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- Oxocarbon colorscheme
  -- {
  --   "nyoom-engineering/oxocarbon.nvim",
  --    lazy = false,
  --    priority = 1000,
  --    config = function()
  --      vim.cmd("colorscheme oxocarbon")
  --      vim.opt.background = "dark"
  --    end,
  --  },
  -- Solarized Osaka
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd("colorscheme solarized-osaka")
  --     vim.opt.background = "dark"
  --   end,
  -- },
  -- Sonokai -- currently using Sonokai as it feels great for markdown
  -- {
  --   "sainnhe/sonokai",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd("colorscheme sonokai")
  --     vim.opt.background = "dark"
  --   end,
  -- },

  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme kanagawa")
      vim.opt.background = "dark"
    end
  },

  -- Treesitter: Superior syntax highlighting
  -- Note: Config is applied automatically by lazy.nvim after plugin loads
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Protected call to avoid errors if module not loaded yet
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup({
          -- Languages for markdown code blocks + general use
          ensure_installed = {
            -- Markdown essentials
            "markdown", "markdown_inline", "mdx",
            -- Common programming languages (for code blocks)
            "python", "javascript", "typescript", "bash", "sh",
            "json", "yaml", "toml", "html", "css",
            "go", "rust", "java", "c", "cpp",
            -- Neovim config languages
            "lua", "vim", "vimdoc",
          },
          highlight = {
            enable = true,
            -- This allows Tree-sitter to highlight markdown code blocks
            additional_vim_regex_highlighting = { "markdown" },
          },
          indent = { enable = true },
        })
      end
    end,
  },

  -- Render Markdown: Inline markdown rendering (headings, bold, lists, code blocks)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      -- Enable rendering by default
      enabled = true,
      -- Render in normal mode as well as insert mode
      render_modes = { "n", "c", "i" },
      -- Heading settings
      heading = {
        -- Use icons for headings
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- Heading backgrounds
        backgrounds = { "RenderMarkdownH1Bg", "RenderMarkdownH2Bg", "RenderMarkdownH3Bg" },
        -- Heading foregrounds
        foregrounds = { "RenderMarkdownH1", "RenderMarkdownH2", "RenderMarkdownH3" },
      },
      -- Code block settings
      code = {
        -- Show language name
        enabled = true,
        -- Icon to use
        icon = "󰘦",
        -- Highlight for code blocks
        highlight = "RenderMarkdownCode",
      },
      -- Bullet settings
      bullet = {
        -- Use nice bullet characters
        icons = { "●", "○", "◆", "◇" },
      },
    },
  },

  -- Bullets.vim: Smart bullet list handling
  {
    "bullets-vim/bullets.vim",
    ft = { "markdown", "text" },
  },

  -- Vim Table Mode: Easy markdown table creation
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    config = function()
      -- Set markdown-compatible corners
      vim.g.table_mode_corner = "|"
    end,
  },

  -- Spider: Better word motions for prose
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Spider-w" },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Spider-e" },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Spider-b" },
    },
  },

  -- Image.nvim: Display images in markdown files
  {
    "3rd/image.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      backend = "kitty", -- Ghostty supports Kitty graphics protocol
      processor = "magick_cli", -- Uses ImageMagick CLI
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          -- Only render image at cursor to avoid overlays
          only_render_image_at_cursor = true,
          only_render_image_at_cursor_mode = "popup", -- Use popup mode to avoid text overlap
          filetypes = { "markdown" },
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 40, -- Reduced from 50 to prevent overlap
      window_overlap_clear_enabled = true, -- Clear images when windows overlap
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "scrollview", "scrollview_sign" },
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = false,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },

  -- Image paste: Paste images from clipboard into markdown
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = true,
        drag_and_drop = {
          insert_mode = true,
        },
        use_absolute_path = false,
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
    },
  },
})
