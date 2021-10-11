let mapleader = " " "set leader key
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins managened by vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
Plug 'neovim/nvim-lspconfig' "A collection of common configurations for Neovim's built-in language server client
Plug 'vim-scripts/The-NERD-tree'
Plug '/usr/local/opt/fzf' "Fuzz file opener
Plug 'junegunn/fzf.vim' "fzf ❤️ vim
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' } "The plugin that powerfully integrates fzf and (Neo)vim. It is also possible to integrate with coc.nvim.
Plug 'sheerun/vim-polyglot' "A collection of language packs for Vim.
Plug 'Chiel92/vim-autoformat' "Provide easy code formatting in Vim by integrating existing code formatters.
Plug 'mileszs/ack.vim' " Quick Search File Content
Plug 'scrooloose/nerdcommenter'  " Vim plugin for intensely orgasmic commenting
Plug 't9md/vim-choosewin' "Land on window you chose like tmux's 'display-pane'
Plug 'gcmt/taboo.vim' "Few utilities for pretty tabs
Plug 'junegunn/vim-peekaboo' "Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
Plug 'SirVer/ultisnips' "The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!
Plug 'ap/vim-css-color' "Preview colours in source code while editing
Plug 'Asheq/close-buffers.vim' "Bdelete several buffers at once
Plug 'MattesGroeger/vim-bookmarks' "Bookmarks Manager
Plug 'simnalamburt/vim-mundo' "Undo tree visualizer
Plug 'mattn/emmet-vim' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main'} "A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' "Gaze deeply into unknown regions using the power of the moon.
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'branch': 'main', 'do': 'make' } "fzf-native is a c port of fzf. It only covers the algorithm and implements few functions to support calculating the score.
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
nnoremap <leader>O <cmd>Telescope buffers<CR>
"bdelete buffers not visible in a window
nnoremap <leader><BS> :Bdelete hidden<CR>

"macro
nnoremap  Q @

"save file
nnoremap <leader>s :w<cr>
nnoremap <leader>S :wa<cr>

"fzf
nnoremap <leader>o <cmd>Telescope find_files<cr>
nnoremap <leader>l :FzfPreviewLines<cr>
nnoremap <leader>m :FzfPreviewBookmarks<cr>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" The-Nerd-Tree
nnoremap <leader>w :NERDTree<CR>

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

"vim-bookmarks
let g:bookmark_auto_save = 1
let g:bookmark_auto_save_file = $XDG_CONFIG_HOME.'/nvim/bookmarks'
let g:bookmark_auto_close = 1

"mundo
nnoremap U :MundoToggle<CR>
let g:mundo_preview_bottom=1

lua << EOF
  local nvim_lsp = require('lspconfig')
  local nvim_lsp = require('lspconfig')
  nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
  }

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gs', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ac', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[c', '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>', opts)
    buf_set_keymap('n', ']c', '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  end

  nvim_lsp.diagnosticls.setup{
  on_attach=custom_attach,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'  },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
      filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
      }
    }
  }


  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'tsserver' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

EOF

lua << EOF
  require('telescope').setup {
        defaults = {
        file_sorter = require "telescope.sorters".get_fzy_sorter,
        generic_sorter = require "telescope.sorters".get_fzy_sorter,
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden"
        },
        file_ignore_patterns = {
            "node_modules",
            ".work/.*",
            ".cache/.*",
            ".idea/.*",
            "dist/.*",
            ".git/.*"
        },
        },
  }
  require('telescope').load_extension('fzf')
EOF
