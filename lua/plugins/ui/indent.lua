return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = { char = "│" }, -- Vertical indent lines
    -- indent = { char = "-" },          -- Vertical indent lines
    whitespace = {
      highlight = { "Whitespace" },  -- Enable whitespace visibility
      remove_blankline_trail = true, -- Show spaces at line end
    },
    scope = { enabled = true },      -- Scope highlighting
  },
}
