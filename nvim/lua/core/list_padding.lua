-- list_padding.lua
-- Adds a virtual blank line after each top-level bullet point
-- for improved readability in markdown/mdx files.

local M = {}

local NS = vim.api.nvim_create_namespace("md_list_padding")

-- Matches the start of a top-level list item (-, *, +, or 1.)
local LIST_ITEM = "^%s*[-*+]%s"
local ORDERED_ITEM = "^%s*%d+[.)%]]%s"

local function is_list_item(line)
  return line:match(LIST_ITEM) or line:match(ORDERED_ITEM)
end

local function apply(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, NS, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i, line in ipairs(lines) do
    if is_list_item(line) then
      -- Look ahead: only add padding if this is NOT the last line
      -- and the next non-empty line is also a list item (i.e. consecutive bullets)
      local next_idx = i + 1
      local next_line = lines[next_idx]
      if next_line ~= nil then
        -- Add one virtual blank line below this bullet's last wrapped line
        vim.api.nvim_buf_set_extmark(bufnr, NS, i - 1, 0, {
          virt_lines = { {} },         -- one empty virtual line
          virt_lines_above = false,
        })
      end
    end
  end
end

function M.setup()
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
    pattern = { "*.md", "*.mdx" },
    callback = function(ev)
      apply(ev.buf)
    end,
  })
end

return M
