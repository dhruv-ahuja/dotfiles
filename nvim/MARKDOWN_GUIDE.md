# Neovim Markdown/MDX Quick Reference Guide

## 📸 Image Operations

### Adding Images
- **Paste from clipboard**: `<leader>p` (you'll be prompted for a filename)
  - Copies image from clipboard and creates markdown link
  - Example: `![alt text](./images/screenshot.png)`
  
- **Drag & Drop**: Just drag an image file into Neovim in insert mode
  - Works automatically with img-clip.nvim

### Viewing Images
- **Inline image preview**: Images automatically render inline when cursor is on them
  - Uses `image.nvim` with Kitty graphics protocol (Ghostty support)
  - Shows as popup to avoid text overlap
  - Only displays when cursor is on the image line

## 🔗 Link Navigation

### Opening Links
- **Open link under cursor**: `gx`
  - Works for URLs: `https://example.com`
  - Works for file paths: `./other-file.md`
  - Opens in default browser/application

### Link Creation
- Select text in visual mode, then create link manually:
  1. Select text: `vw` or `viw` (visual select word)
  2. Type: `c` to change, then `[original text](url)`

## 📝 Lists & Bullets

### Smart Bullet Handling (bullets.vim)
- **Continue list**: Press `Enter` in a list item
  - Automatically continues with next bullet
  - Works with: `- `, `* `, `+ `, `1. `, `2. `, etc.
  
- **Indent/Outdent**: 
  - Indent: `>>` or `Ctrl-t` (insert mode)
  - Outdent: `<<` or `Ctrl-d` (insert mode)
  - Automatically switches bullet styles
  
- **Toggle checkbox**: `<leader>x` (in bullets.vim configs)
  - `- [ ]` → `- [x]`
  - `- [x]` → `- [ ]`

### Creating Lists
```markdown
- First level
  - Second level (use Tab or >>)
    - Third level
      - Fourth level

1. Numbered list
2. Auto-increments
3. When you press Enter
```

## 📊 Tables

### Table Mode Commands
- **Enable table mode**: `:TableModeEnable` or `:TableModeToggle`
- **Disable table mode**: `:TableModeDisable`

### Creating Tables
1. Enable table mode: `:TableModeEnable`
2. Start typing with pipes:
   ```
   | Header 1 | Header 2 | Header 3 |
   ```
3. Press `||` to create separator row automatically
4. Keep typing rows - they auto-align!

### Table Navigation
- `Ctrl-n` / `Ctrl-p`: Next/Previous cell (when in table mode)

### Example Table Workflow
```markdown
| Name | Age | City |
|------|-----|------|
| John | 30  | NYC  |
| Jane | 25  | LA   |
```

## ✍️ Text Editing

### Better Word Motions (nvim-spider)
- `w`: Next word (skips punctuation intelligently)
- `b`: Previous word
- `e`: End of word
- Works in normal, visual, and operator-pending modes

### Text Objects (built-in Vim)
- `ciw`: Change inner word
- `ci"`: Change inside quotes
- `ci(`: Change inside parentheses
- `ci[`: Change inside brackets
- `cit`: Change inside tag (useful for HTML/JSX in MDX)

## 🎨 Markdown Rendering

Your config has `render-markdown.nvim` active, which means:

### What You See
- **Headings**: Beautiful icons (󰲡, 󰲣, 󰲥, etc.) and backgrounds
- **Code blocks**: Syntax highlighted with language indicator
- **Lists**: Pretty bullet characters (●, ○, ◆, ◇)
- **Bold/Italic**: Concealed markup (just see **bold** as bold)
- **Links**: Concealed brackets (just see the link text)

### Toggle Rendering
- If you need to see raw markdown: `:set conceallevel=0`
- Return to pretty rendering: `:set conceallevel=2`

## 📋 Useful General Commands

### Code Fences
```markdown
```python
def hello():
    print("Hello, world!")
```

Type the language name after the triple backticks for syntax highlighting.

### Headings
```markdown
# H1 - Main Title
## H2 - Section
### H3 - Subsection
#### H4 - Sub-subsection
```

### Formatting
```markdown
**bold text**
*italic text*
***bold and italic***
`inline code`
~~strikethrough~~
```


### Blockquotes
```markdown
> This is a quote
> Continues on next line
>
> New paragraph in quote
```

## 🔧 Spell Checking

### Commands
- **Toggle spell check**: `:set spell!` or `:set nospell`
- **Next misspelled word**: `]s`
- **Previous misspelled word**: `[s`
- **Suggest corrections**: `z=` (when cursor is on misspelled word)
- **Add to dictionary**: `zg`
- **Mark as wrong**: `zw`

**Note**: Spell checking is automatically enabled for markdown/mdx files!

## 🎯 Navigation

### Jump to Headings
- Search for heading: `/## Your Heading`
- Jump to next/previous search: `n` / `N`

### File Navigation
- **Go to file under cursor**: `gf`
  - Works for relative paths like `./other-file.md`
  - Add `.md` extension automatically with: `:set suffixesadd+=.md`

### Marks
- Set mark: `ma` (sets mark 'a')
- Jump to mark: `'a` (jump to line) or `` `a `` (jump to exact position)
- List marks: `:marks`

## 🚀 Pro Tips

### Quick Link to URL
1. Yank URL from browser: `Cmd+C`
2. In Neovim, select link text: `vw`
3. Type: `c[<Ctrl-r>+]()`
4. Paste URL between parentheses

### Paste Formatted Code
1. Copy code from anywhere
2. In Neovim: type ` ```language`
3. Press Enter
4. Paste your code
5. Type ` ``` ` on new line

### Quick TODO List
```markdown
- [ ] Task 1
- [ ] Task 2
- [x] Completed task
```

### Front Matter (for MDX)
```yaml
---
title: My Blog Post
date: 2026-02-10
tags: [markdown, neovim]
---
```

## ⌨️ Custom Keybindings You Might Want to Add

If you want to extend your config, consider adding these to your Neovim config:

```lua
-- In your core/options.lua or autocmds.lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Open link in browser
    vim.keymap.set("n", "<leader>o", "gx", { buffer = true, desc = "Open link" })
    
    -- Insert current date
    vim.keymap.set("i", "<C-d>", function()
      return os.date("%Y-%m-%d")
    end, { buffer = true, expr = true, desc = "Insert date" })
    
    -- Bold word under cursor
    vim.keymap.set("n", "<leader>b", "viw<Esc>a**<Esc>bi**<Esc>", { buffer = true, desc = "Bold word" })
    
    -- Italic word under cursor
    vim.keymap.set("n", "<leader>i", "viw<Esc>a*<Esc>bi*<Esc>", { buffer = true, desc = "Italic word" })
  end,
})
```

## 📖 Quick Cheat Sheet

| Action | Command |
|--------|---------|
| Paste image | `<leader>p` |
| Open link | `gx` |
| Next misspelling | `]s` |
| Spell suggestions | `z=` |
| Toggle table mode | `:TableModeToggle` |
| Show concealed text | `:set conceallevel=0` |
| Re-enable rendering | `:set conceallevel=2` |
| Format table | `||` (in table mode) |

---

**Tip**: Keep this file open in a split while editing markdown:
```
:vsplit ~/.config/nvim/MARKDOWN_GUIDE.md
```

Happy writing! ✨
