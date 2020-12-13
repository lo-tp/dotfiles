let mapleader = " " "set leader key
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins managened by vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
Plug 'vim-scripts/The-NERD-tree'
Plug '/usr/local/opt/fzf' "Fuzz file opener
Plug 'junegunn/fzf.vim' "fzf ❤️ vim
Plug 'sheerun/vim-polyglot' "A collection of language packs for Vim.
Plug 'Chiel92/vim-autoformat' "Provide easy code formatting in Vim by integrating existing code formatters.
Plug 'mileszs/ack.vim' " Quick Search File Content
Plug 'scrooloose/nerdcommenter'  " Vim plugin for intensely orgasmic commenting
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} "Intellisense engine for vim8 & neovim
Plug 't9md/vim-choosewin' "Land on window you chose like tmux's 'display-pane'
Plug 'gcmt/taboo.vim' "Few utilities for pretty tabs
Plug 'junegunn/vim-peekaboo' "Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
Plug 'SirVer/ultisnips' "The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!
Plug 'ap/vim-css-color' "Preview colours in source code while editing
Plug 'Asheq/close-buffers.vim' "Bdelete several buffers at once
Plug 'mattn/emmet-vim' 
call plug#end()

" ultisnips config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Tabline Config
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=None   ctermbg=White     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Related
nnoremap <C-T> :tabnew<cr>
nnoremap <c-w> :q<cr>

" Window Related
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-K> <C-W>k
nnoremap <C-J> <C-W>j
nnoremap <leader>z :vsplit<cr>
nnoremap <leader>Z :split<cr>
nnoremap <F1> :res -1<cr>
nnoremap <F2> :res +1<cr>
nnoremap <F7> :vertical res -1<cr>
nnoremap <F8> :vertical res +1<cr>

" Buffer Related
nnoremap <leader>H :bp<CR>
nnoremap <leader>L :bn<CR>
nnoremap <leader>O :Buffers<CR>
"bdelete buffers not visible in a window
nnoremap <leader><BS> :Bdelete hidden<CR>

"macro
nnoremap  Q @

"save file
nnoremap <leader>s :w<cr>
nnoremap <leader>S :wa<cr>

"fzf
nnoremap <leader>o :FZF <cr>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" The-Nerd-Tree
nnoremap <leader>w :NERDTree<CR>

"coc-list outline
nnoremap <leader>r :CocList outline<cr>

"save session to $VIM_SESSION if this env veriable exists
if !empty($VIM_SESSION)
  nnoremap s :mks! $VIM_SESSION <cr>
endif

"fzf
set rtp+=/usr/local/opt/fzf

"set visual mode selected color
hi Visual cterm=NONE ctermbg=green ctermfg=red

" cucor and curlor line related stuff
set cul
hi CursorLine cterm=NONE ctermbg=darkgrey ctermfg=lightgreen
autocmd InsertEnter * set cursorcolumn
autocmd InsertLeave * set nocursorcolumn


set encoding=utf-8 " set encoding

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

"config for coc.vim
source $XDG_CONFIG_HOME/nvim/config/coc.vim

"choosewin
nmap  -  <Plug>(choosewin)
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
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

"list char settings
set list
set listchars=eol:⏎
