""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins managened by vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required

runtime ./plugin.vim


" Tabline Config
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=None   ctermbg=White     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

" Color related config
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
highlight Normal  ctermbg=239
highlight clear LineNr
highlight CursorLineNr ctermbg=243 
highlight CursorLine cterm=NONE ctermbg=243 ctermfg=lightgreen


"set visual mode selected color
hi Visual cterm=NONE ctermbg=green ctermfg=red

" cucor and curlor line related stuff
set cul
autocmd InsertEnter * set cursorcolumn
autocmd InsertLeave * set nocursorcolumn


set encoding=utf-8 " set encoding

set number "turn line number
set relativenumber "turn on relative line number
set clipboard=unnamed "use system clipboard

" python support for neo vim
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" turn off query highlight by default
set nohls

" use ag to do file content search
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set tab indent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" " when indenting with '>', use 4 spaces width
set shiftwidth=2
" " On pressing tab, insert 4 spaces
set expandtab

let g:choosewin_overlay_enable = 1

let g:choosewin_color_overlay = {
      \ 'gui': ['DodgerBlue3', 'DodgerBlue3'],
      \ 'cterm': [105, 105]
      \ }
let g:choosewin_color_overlay_current = {
      \ 'gui': ['firebrick1', 'firebrick1'],
      \ 'cterm': [124, 124]
      \ }
let g:choosewin_tabline_replace = 0
let g:choosewin_blink_on_land= 0

"taboo
let g:taboo_tab_format='  %N: %P  |'
set sessionoptions+=tabpages,globals

"typescript settings
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.react

"list char settings
set list
set listchars=eol:⏎

let g:airline_theme='angr'

" Use persistent history.
if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif
set undodir=/tmp/.vim-undo-dir
set undofile

" config for indentation display
let g:indentLine_color_term = 47
let g:indentLine_char = '┆'

runtime ./keymapping.vim
