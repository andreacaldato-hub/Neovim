return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    lazy = true,
    keys = {
      { "<leader>ff", group = "Telescope" },
      { "<leader>fn", group = "Telescope" },
      { "<leader>fc", group = "Telescope" },
      { "<leader>fF", group = "Telescope" },
      { "<leader>fb", group = "Telescope" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local home = vim.fn.expand("~")

      require("telescope").setup({
        defaults = {
          hidden = true,
          layout_strategy = "flex",
          layout_config = { horizontal = { preview_width = 0.7 } },

          -- vertical red bar
          selection_caret = "▌ ", -- the FZF-style bar
          entry_prefix = " ", -- space before items
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        },
      })

      telescope.load_extension("fzf")

      local function set_telescope_hl()
        vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#E0E2EA", bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#3D3D3D" })
        vim.api.nvim_set_hl(0, "TelescopeResultsLine", { bold = true })
        vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#3D3D3D", fg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#3D3D3D" })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#3D3D3D" })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#3D3D3D" })
        vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", {
          fg = "#d7005f",
          bg = "NONE",
          bold = true,
        })
        vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#89b482", bold = false })
      end

      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        callback = set_telescope_hl,
      })
      set_telescope_hl()

      -- === Keymaps ===
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({
          cwd = vim.fn.getcwd(),
          hidden = true,                        -- show dotfiles
          file_ignore_patterns = { "^%.git/" }, -- ignore .git folder
        })
      end, { desc = "Find files (cwd)", silent = true })
      vim.keymap.set("n", "<leader>fn", function()
        builtin.find_files({ cwd = home .. "/dotfiles/.config/nvim" })
      end, { desc = "Find nvim config" })

      vim.keymap.set("n", "<leader>fc", function()
        require("telescope.builtin").find_files({
          cwd = home .. "/dotfiles",
          hidden = true,
          follow = false,
          file_ignore_patterns = { "%.git/", "%.swp$", "%.bak$" },
        })
      end, { desc = "Find dotfiles" })

      vim.keymap.set("n", "<leader>fF", function()
        builtin.find_files({ cwd = home, hidden = true, file_ignore_patterns = { "^%.git/" } })
      end, { desc = "Find home files" })

      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
    end,
  },
}
