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
          -- Default to global black
          local exe = "black"
          
          -- Check for local virtual environment in current working directory
          local venv_path = vim.fn.getcwd() .. "/.venv/bin/black"
          local alt_venv_path = vim.fn.getcwd() .. "/venv/bin/black"
          
          if vim.fn.executable(venv_path) == 1 then
            exe = venv_path
          elseif vim.fn.executable(alt_venv_path) == 1 then
            exe = alt_venv_path
          end

          return {
            exe = exe,
            args = {
              "-q", 
              "-",
            },
            stdin = true
          }
        end
      },
    }
  }
)
