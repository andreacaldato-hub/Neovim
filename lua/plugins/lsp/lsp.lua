return {
    "neovim/nvim-lspconfig",
    -- Enable inline diagnostics (THIS is what you want)
    vim.diagnostic.config({
        virtual_text = true,
        update_in_insert = false,
        severity_sort = false
    }),
    -- Auto format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
            vim.lsp.buf.format({ async = false })
        end,
    }),
    config = function()
        local servers = {
            "lua_ls",
            "clangd",
            "pyright",
        }

        vim.lsp.enable(servers)
    end,
}
