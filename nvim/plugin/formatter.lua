local tsFormat = function()
    return {
      exe = "prettier",
      args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
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
      typescript = {
        tsFormat
      },
      html = {
        htmlFormat
      },
    }
  }
)
