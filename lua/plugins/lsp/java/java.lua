return
{
  'nvim-java/nvim-java',
  ft = 'java',
  config = function()
    require('java').setup()
    vim.lsp.enable('jdtls')

    -- Per Java teniamo jdtls (con i suoi semantic tokens LSP) come unica
    -- colorazione, quindi spegniamo l'highlighting di tree-sitter e
    -- ripristiniamo la sintassi regex di Vim.
    -- Nota: per BufEnter/BufWinEnter il pattern matcha il *nome file*, non
    -- il filetype, quindi usiamo '*.java'.
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      pattern = '*.java',
      callback = function(args)
        vim.treesitter.stop(args.buf)
        vim.bo[args.buf].syntax = 'ON'
      end,
    })
  end,
}
