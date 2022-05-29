local nvim_lsp = require('lspconfig')

local linters = {
  eslint = {
    command = 'eslint_d',
    rootPatterns = { '.git' },
    debounce = 100,
    args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
    sourceName = 'eslint',
    parseJson = {
      errorsRoot = '[0].messages',
      line = 'line',
      column = 'column',
      endLine = 'endLine',
      endColumn = 'endColumn',
      message = '[eslint] ${message} [${ruleId}]',
      security = 'severity'
    },
    securities = {
      [2] = 'error',
      [1] = 'warning'
    }
  },
} 

local filetypes = {
  javascript = 'eslint',
  javascriptreact = 'eslint',
  typescript = 'eslint',
  typescriptreact = 'eslint',
  vue = 'eslint',
}

local formatters = {
    prettier = {command = "./node_modules/.bin/prettier", args = {"--stdin-filepath", "%filepath"}}
}

local formatFiletypes = {
    typescript = "prettier",
    typescriptreact = "prettier"
}

nvim_lsp.diagnosticls.setup{
  filetypes = { 'vue', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'  },
  init_options = {
    linters = linters,
    filetypes = filetypes,
    formatters = formatters,
    formatFiletypes = formatFiletypes
  }
}
