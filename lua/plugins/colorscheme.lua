return {
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_enable_italic = false
            vim.g.sonokai_transparent_background = 1

            vim.cmd("colorscheme sonokai")

            local hi = vim.api.nvim_set_hl

            -- Core transparency

            --Floating windows
            hi(0, "NormalFloat", { bg = "none" })
            hi(0, "FloatBorder", { bg = "none" })

            -- -- Lazy.nvim
            -- hi(0, "LazyNormal", { bg = "none" })

            -- -- Mason
            -- hi(0, "MasonNormal", { bg = "none" })

            -- -- Prevent overwrite on reload
            -- vim.api.nvim_create_autocmd("ColorScheme", {
            --     pattern = "*",
            --     callback = function()
            --         hi(0, "NormalFloat", { bg = "none" })
            --         hi(0, "FloatBorder", { bg = "none" })
            --         hi(0, "NeoTreeNormal", { bg = "none" })
            --         hi(0, "NeoTreeFloat", { bg = "none" })
            --         hi(0, "LazyNormal", { bg = "none" })
            --         hi(0, "MasonNormal", { bg = "none" })
            --     end,
            -- })
        end,
    },
}
