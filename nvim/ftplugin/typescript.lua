local command = os.getenv('VIM_LINTER') and ":Format<cr>" or ":EslintFixAll<cr>" 
vim.api.nvim_set_keymap(
  "n",
  "Y",
  command,
  { noremap = true }
 )

