-- Neovim configuration
-- Lua-based config with markdown note-taking support

-- Load core settings
require("core.options")

-- Load plugin manager and plugins
require("core.lazy")

-- Load autocmds (markdown-specific settings)
require("core.autocmds")
