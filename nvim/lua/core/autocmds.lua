-- Autocmds for Markdown files
-- Optimized for note-taking and reading

-- Detect MDX files and treat them as markdown
vim.filetype.add({
  extension = {
    mdx = "markdown",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Soft wrap for prose (wrap at word boundaries)
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    
    -- Spell checking
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    
    -- Concealment for cleaner markdown rendering
    -- Level 2: hide markup for bold, italic, links but show replacement text
    vim.opt_local.conceallevel = 2
    
    -- Optional: Set textwidth to 0 to rely on soft wrap only
    -- Or set to 80 for hard wrapping at 80 columns
    vim.opt_local.textwidth = 0
    
    -- Better list formatting
    vim.opt_local.formatoptions:append("n")

    -- Auto-open Zen Mode for focused, width-capped reading
    -- Small defer to ensure the buffer is fully loaded first
    vim.defer_fn(function()
      local ok, zen = pcall(require, "zen-mode")
      if ok then zen.open() end
    end, 50)
  end,
})
