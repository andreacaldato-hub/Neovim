-- Entry point for the Neovim configuration.
-- Modules are loaded lazily via config.lazy when possible.

-- LSP configuration and servers (needed early for LspAttach)
require("config.lsp")

-- Custom highlight groups / overrides
require("config.highlights")

-- Plugin manager bootstrap and plugin loading (lazy.nvim)
require("config.lazy")

-- LuaSnip LaTeX snippets
require("plugins.latex.snippets")
