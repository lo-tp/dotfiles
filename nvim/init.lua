-- be iMproved, required
vim.opt.compatible=false

-- plugins managened by vim-plug
vim.api.nvim_command([[
  runtime ./plugin.vim
]])
-- set encoding
vim.opt.encoding='utf-8' 
--turn line number
vim.opt.number=true 
--turn on relative line number
vim.opt.relativenumber=true 
--use system clipboard
vim.opt.clipboard='unnamed' 


-- python support for neo vim
vim.g.python_host_prog = '/usr/local/bin/python2'
vim.g.python3_host_prog = '/usr/local/bin/python3'

-- turn off query highlight by default
vim.opt.hls=false

-- use ag to do file content search
if vim.fn.executable('ag') then
  vim.g.ackprg = 'ag --vimgrep'
end

-- config for indentation display
vim.g.indentLine_color_term = 47
vim.g.indentLine_char = '┆'

-- Use persistent history.
os.execute("mkdir /tmp/.vim-undo-dir")
vim.opt.undodir="/tmp/.vim-undo-dir"
vim.opt.undofile=true

-- list char settings
vim.opt.list=true
vim.opt.listchars='eol:⏎'

-- airline theme config
vim.g.airline_theme='angr'

-- taboo
vim.g.taboo_tab_format='  %N: %P  |'

-- tab relevant config
-- show existing tab with 4 spaces width
vim.opt.tabstop=2
-- when indenting with '>', use 4 spaces width
vim.opt.shiftwidth=2
-- On pressing tab, insert 4 spaces
vim.opt.expandtab=true


-- vim-choosewin plugin config
vim.g.choosewin_overlay_enable = 1
vim.g.choosewin_color_overlay = {
  gui= {'DodgerBlue3', 'DodgerBlue3'},
  cterm= {105, 105}
}
vim.g.choosewin_color_overlay_current = {
  gui= {'firebrick1', 'firebrick1'},
  cterm={124, 124}
}
vim.g.choosewin_tabline_replace = 0
vim.g.choosewin_blink_on_land= 0

-- show vertical cursor line in editing mode
vim.opt.cul=true
vim.api.nvim_command([[
  autocmd InsertEnter * set cursorcolumn
  autocmd InsertLeave * set nocursorcolumn
]])

-- Color config
vim.g.gruvbox_contrast_dark = 'hard'
vim.api.nvim_command([[
  colorscheme gruvbox
  highlight Normal  ctermbg=239
  highlight clear LineNr
  highlight CursorLineNr ctermbg=243 
  highlight CursorLine cterm=NONE ctermbg=243 ctermfg=lightgreen
]])

--set visual mode selected color
vim.api.nvim_command([[
  highlight Visual cterm=NONE ctermbg=green ctermfg=red
]])

-- Tabline Config
vim.api.nvim_command([[
   highlight TabLine      ctermfg=White  ctermbg=239     cterm=NONE
   highlight TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
]])

-- typescript settings
vim.api.nvim_command([[
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.react
]])

require('keymapping')
