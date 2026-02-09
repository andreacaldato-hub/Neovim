return {
  -- Theme
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("kanagawa").setup({
        transparent = true,
        globalStatus = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      })
      vim.cmd("colorscheme kanagawa")

      -- Floating windows
      local hi = vim.api.nvim_set_hl
      hi(0, "NormalFloat", { bg = "none" })
      hi(0, "FloatBorder", { bg = "none" })

      -- Neo-tree
      hi(0, "NeoTreeNormal", { bg = "none" })
      hi(0, "NeoTreeFloat", { bg = "none" })

      -- Lazy.nvim
      hi(0, "LazyNormal", { bg = "none" })

      -- Mason
      hi(0, "MasonNormal", { bg = "none" })

      -- Ensure future colorscheme reloads don’t overwrite
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          hi(0, "NormalFloat", { bg = "none" })
          hi(0, "FloatBorder", { bg = "none" })
          hi(0, "NeoTreeNormal", { bg = "none" })
          hi(0, "NeoTreeFloat", { bg = "none" })
          hi(0, "LazyNormal", { bg = "none" })
          hi(0, "MasonNormal", { bg = "none" })
        end,
      })
    end,
  },
}
