local format = function()
    return {
      exe = "prettier",
      args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
      stdin = true
    }
end

require("formatter").setup(
  {
    logging = true,
    filetype = {
      ['typescript.react'] = {
        format
      },
      typescript = {
        format
      },
    }
  }
)
