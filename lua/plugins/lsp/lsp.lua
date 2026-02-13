return {
    "neovim/nvim-lspconfig",

    config = function()
        -- Diagnostics
        vim.diagnostic.config({
            virtual_text = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- Format on save + inlay hints when LSP attaches
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                local bufnr = args.buf

                -- Format on save
                if client and client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end

                -- Inlay hints
                if client and client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
            end,
        })

        -- Servers
        local servers = {
            "lua_ls",
            "clangd",
            "pyright",
            "ltex",
            "texlab",
            "yamlls",
            "ts_ls",
            "html",
            "bashls",
        }

        vim.lsp.enable(servers)
    end,
}
