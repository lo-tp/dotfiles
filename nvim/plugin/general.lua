local nvim_lsp = require('lspconfig')

nvim_lsp.eslint.setup(
{
  filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'vue',
      'typescript.react',
    },
}
)
