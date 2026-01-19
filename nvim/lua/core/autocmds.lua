-- Autocmds for Markdown files
-- Optimized for note-taking and reading

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
  end,
})
