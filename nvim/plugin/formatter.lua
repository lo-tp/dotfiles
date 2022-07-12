local tsFormat = function()
    return {
      exe = "prettier-eslint",
      args = {vim.api.nvim_buf_get_name(0)},
      stdin = true
    }

end

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
