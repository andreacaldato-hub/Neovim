# AGENTS.md - Neovim Configuration

This is a Neovim configuration using Lua with lazy.nvim for plugin management.

## Project Structure

```
.
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── autocmds.lua       # Autocommand definitions
│   │   ├── keymaps.lua         # Keybinding definitions
│   │   ├── lazy.lua            # Plugin manager bootstrap
│   │   └── options.lua         # Neovim options
│   └── plugins/               # Plugin configurations
│       ├── colorscheme.lua
│       ├── file-browser.lua
│       ├── git/
│       │   └── git.lua
│       ├── latex/
│       │   ├── plugins/
│       │   │   └── vimtex.lua
│       │   └── snippets.lua
│       ├── lsp/
│       │   ├── format.lua
│       │   ├── lsp.lua
│       │   └── suggestions.lua
│       ├── opencode.lua
│       ├── telescope.lua
│       ├── ui/
│       │   ├── colorizer.lua
│       │   ├── fidget.lua
│       │   ├── incline.lua
│       │   ├── indent.lua
│       │   └── treesitter.lua
│       └── utils/
│           ├── autopairs.lua
│           ├── comment.lua
│           ├── debug.lua
│           ├── flash.lua
│           ├── harpoon.lua
│           ├── lua-snip.lua
│           ├── matlab.lua
│           ├── mini.lua
│           ├── noice.lua
│           ├── profiler.lua
│           ├── snacks.lua
│           └── treesj.lua
├── .luarc.json                # Lua LSP configuration
└── .gitignore
```

## Build/Lint/Test Commands

### Linting

```bash
# Check Lua syntax with luacheck (if installed)
luacheck lua/

# Lua LSP diagnostics (built-in with nvim)
# Run :checkhealth in Neovim to verify configuration loads correctly
```

### Verification

```bash
# Verify Neovim configuration loads without errors
nvim --headless -c 'quit' 2>&1

# Check plugin loading
nvim --headless -c 'lua print(vim.inspect(require("lazy").plugins()))' -c 'quit'
```

### Single File Testing

```bash
# Test load a specific module
nvim --headless -c 'lua require("config.options")' -c 'quit'

# Check for syntax errors in a file
nvim -es -u NONE +'set rtp+=.' +'lua vim.cmd("dofile(\"lua/plugins/example.lua\")")' +'q' 2>&1
```

## Code Style Guidelines

### General

- **Indentation**: 2 spaces for Lua code
- **Line length**: Soft limit 120 characters
- **File encoding**: UTF-8

### File Structure

1. Plugin specs return a table using lazy.nvim spec format
2. Configuration functions use `config = function()` or `opts = {...}`
3. Plugin modules are lazy-loaded by default unless explicitly marked `lazy = false`

### Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Files | snake_case.lua | `snacks.lua`, `keymaps.lua` |
| Functions | snake_case | `set_blink_hl()`, `get_port_from_dir()` |
| Variables | snake_case | `local opts = {}`, `local live_servers = {}` |
| Tables/Modules | PascalCase for module returns | `Snacks.picker.grep()` |
| Keymaps descriptions | Sentence case | `desc = "Open Neogit"` |
| Highlight groups | PascalCase | `BlinkCmpMenu`, `NormalFloat` |

### Imports and Dependencies

```lua
-- Plugin spec returns
return {
    "author/plugin-name",
    lazy = true,  -- lazy-load by default
    keys = {},    -- load on keybinds
    opts = {},    -- configuration options
    config = function() end,  -- setup function
    dependencies = {},  -- plugin dependencies
}

-- Require statements
local snacks = require("snacks")
local opts = { noremap = true, silent = true }
```

### Keymaps Pattern

```lua
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Standard keymap
map("n", "<leader>x", ":bd!<CR>", opts)

-- With description
map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })

-- Conditional keymap
map("n", "<C-h>", function()
    -- implementation
end, { desc = "Navigate left", expr = true })
```

### Autocmds Pattern

```lua
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- implementation
    end,
})
```

### Options Pattern

```lua
-- Use vim.opt for boolean/list options
vim.opt.number = true
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Use vim.g for global variables
vim.g.mapleader = " "
vim.g.vimtex_view_method = "zathura"

-- Use vim.api for advanced settings
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
```

### Error Handling

```lua
-- Use pcall for optional dependencies
pcall(require, "config.options")

-- Check for errors from system calls
local out = vim.fn.system({ "git", "clone", url, lazypath })
if vim.v.shell_error ~= 0 then
    -- handle error
end
```

### Comments

- Use `--` for single-line comments
- Avoid unnecessary comments; code should be self-documenting
- Use section headers for major divisions:
  ```lua
  -- ─── Keymaps ───────────────────────────────────────────────────────────────────
  ```

### Lua Annotations

Use LuaLS annotations for better IDE support:

```lua
---@type snacks.Config
opts = {}

---@param client vim.lsp.client
---@param bufnr number
local function on_attach(client, bufnr)
    -- implementation
end
```

### Lazy Plugin Spec Best Practices

1. Always specify `lazy = false` for plugins needed at startup
2. Use `priority = 1000` for colorschemes
3. Group related plugins in subdirectories
4. Use `dependencies` array for plugin dependencies
5. Keys should include `desc` for documentation

### Tables and Arrays

```lua
-- Use table constructors for short arrays
local signs = { text = "+", numhl = "DiagnosticSignError" }

-- Multi-line tables with trailing comma
return {
    "author/plugin",
    lazy = false,
    opts = {
        enabled = true,
        timeout = 3000,
    },
}
```

## Additional Notes

- **.luarc.json**: Contains Lua LSP diagnostics configuration (vim is a global)
- **No test framework**: Configuration is verified manually
- **Plugin manager**: lazy.nvim (LazyVim-style setup)
- **Supported file types**: Lua, LaTeX (vimtex), C, MATLAB
