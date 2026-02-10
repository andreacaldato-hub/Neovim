return {
    "lervag/vimtex",
    lazy = false,

    init = function()
        -- Viewer
        vim.g.vimtex_view_method = "zathura"

        -- Enable forward/inverse search
        vim.g.vimtex_view_general_viewer = "zathura"
        vim.g.vimtex_view_general_options = "--synctex-forward @line:@col:@tex @pdf"

        -- Compiler
        vim.g.vimtex_compiler_method = "latexmk"

        vim.g.vimtex_compiler_latexmk = {
            build_dir = "",
            continuous = 1,
            executable = "latexmk",
            options = {
                "-pdf",
                "-shell-escape",
                "-interaction=nonstopmode",
                "-synctex=1",
                "-file-line-error",
            },
        }

        -- Quickfix (error window)
        vim.g.vimtex_quickfix_mode = 1
        vim.g.vimtex_quickfix_open_on_warning = 0

        -- Syntax / conceal
        vim.g.vimtex_syntax_enabled = 1
        vim.g.vimtex_syntax_conceal_disable = 1

        -- Folding
        vim.g.vimtex_fold_enabled = 0

        -- Disable VimTeX default mappings if you use your own
        -- vim.g.vimtex_mappings_enabled = 0

        -- Completion (let blink/LSP handle it)
        vim.g.vimtex_complete_enabled = 0

        -- Error suppression
        vim.g.vimtex_log_ignore = {
            "Underfull",
            "Overfull",
            "specifier changed to",
            "Token not allowed in a PDF string",
        }

        -- Open PDF on compile
        vim.g.vimtex_view_automatic = 1
    end,
}
