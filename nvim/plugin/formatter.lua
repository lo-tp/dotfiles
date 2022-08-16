local linter = os.getenv('VIM_LINTER')

local tsFormatByPrettier = function()
    return {
      exe = "prettier",
      args = {
        '--stdin-filepath',
        vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
      },
      stdin = true
    }
end

local tsFormatByPrettierEslint = function()
    return {
      exe = "prettier-eslint",
      args = {vim.api.nvim_buf_get_name(0)},
      stdin = true
    }
end

local tsFormat = (linter == 'prettier' and tsFormatByPrettier or tsFormatByPrettierEslint)

local htmlFormat = function()
    return {
      exe = "prettyhtml",
      args = {"--stdin"},
      stdin = true
    }
end

require("formatter").setup(
  {
    logging = true,
    filetype = {
      ['javascript'] = {
        tsFormat
      },
      ['typescript.react'] = {
        tsFormat
      },
      vue = {
        tsFormat
      },
      typescript = {
        tsFormat
      },
      html = {
        htmlFormat
      },
      python = {
      function()
        return {
          exe = "black",
          args = {
            "-q -",
          },
          stdin = true
        }
      end
      },
    }
  }
)
