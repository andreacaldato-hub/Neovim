-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Blink.cmp documentation window border color (VSCode-like)

-- Pointer asterisk highlighting
vim.api.nvim_set_hl(0, "@operator", { fg = "#F14C4C" })
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- disable semantic tokens only for lua files
    if client.name == "lua_ls" then
      client.server_capabilities.semanticTokensProvider = nil
    end

    local opts = { buffer = event.buf }
    -- ... rest of your keymaps
  end,
})
-- LSP Hover/Documentation window border
