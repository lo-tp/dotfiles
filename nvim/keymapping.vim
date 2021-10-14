let mapleader = " " "set leader key

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
nnoremap <leader>O <cmd>Telescope buffers<CR>
"bdelete buffers not visible in a window
nnoremap <leader><BS> :Bdelete hidden<CR>

"macro
nnoremap  Q @

"save file
nnoremap <leader>s :w<cr>
nnoremap <leader>S :wa<cr>

"Telescope Find
nnoremap <leader>o <cmd>Telescope find_files<cr>

" The-Nerd-Tree
nnoremap <leader>w :NERDTree<CR>

"save session to $VIM_SESSION if this env veriable exists
if !empty($VIM_SESSION)
  nnoremap s :mks! $VIM_SESSION <cr>
endif

"choosewin
nmap  -  <Plug>(choosewin)
