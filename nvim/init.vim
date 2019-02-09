let mapleader = " " "set leader key
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins managened by vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
Plug 'vim-scripts/The-NERD-tree'
Plug '/usr/local/opt/fzf' "Fuzz file opener
Plug 'sheerun/vim-polyglot' "A collection of language packs for Vim.
Plug 'neomake/neomake' "Asynchronous linting and make framework for Neovim/Vim
Plug 'benjie/local-npm-bin.vim' "Prefer local eslint over global with neomake
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "Dark powered asynchronous completion framework for neovim/Vim8
Plug 'Chiel92/vim-autoformat' "Code formatting
Plug 'mileszs/ack.vim' " Quick Search File Content
Plug 'scrooloose/nerdcommenter'  " Vim plugin for intensely orgasmic commenting
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Related
nnoremap <C-T> :tabnew<cr>
nnoremap <c-w> :q<cr>
nnoremap <leader>h gT
nnoremap <leader>l gt

" Window Related
nnoremap <leader>z :vsplit<cr>
nnoremap <leader>Z :split<cr>
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-K> <C-W>k
nnoremap <C-J> <C-W>j
nnoremap <F1> :res -1<cr>
nnoremap <F2> :res +1<cr>
nnoremap <F7> :vertical res -1<cr>
nnoremap <F8> :vertical res +1<cr>

"save file
nnoremap <leader>s :w<cr>
nnoremap <leader>S :wa<cr>

"fzf
nnoremap <leader>o :FZF <cr>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" The-Nerd-Tree
nnoremap <leader>w :NERDTree<CR>

" autoformat
nnoremap Y :Autoformat<CR>

"fzf
set rtp+=/usr/local/opt/fzf

"set visual mode selected color
hi Visual cterm=NONE ctermbg=green ctermfg=red

" cucor and curlor line related stuff
set cul
hi CursorLine cterm=NONE ctermbg=darkgrey ctermfg=lightgreen

set encoding=utf-8 " set encoding

call neomake#configure#automake('rw', 1000) "auto neomake when reading a buffer (after 1s), and when writing (no delay).

set relativenumber "turn on relative line number
set clipboard=unnamed "use system clipboard

" python support for neo vim
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" Use deoplete.
let g:deoplete#enable_at_startup = 1

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
