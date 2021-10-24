call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
Plug 'neovim/nvim-lspconfig' "A collection of common configurations for Neovim's built-in language server client
Plug 'vim-scripts/The-NERD-tree'
Plug 'Chiel92/vim-autoformat' "Provide easy code formatting in Vim by integrating existing code formatters.
Plug 'mileszs/ack.vim' " Quick Search File Content
Plug 'scrooloose/nerdcommenter'  " Vim plugin for intensely orgasmic commenting
Plug 't9md/vim-choosewin' "Land on window you chose like tmux's 'display-pane'
Plug 'gcmt/taboo.vim' "Few utilities for pretty tabs
Plug 'junegunn/vim-peekaboo' "Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
Plug 'ap/vim-css-color' "Preview colours in source code while editing
Plug 'Asheq/close-buffers.vim' "Bdelete several buffers at once
Plug 'mattn/emmet-vim' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main'} "A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' "Gaze deeply into unknown regions using the power of the moon.
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'branch': 'main', 'do': 'make' } "fzf-native is a c port of fzf. It only covers the algorithm and implements few functions to support calculating the score.
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main'} "Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main'} "LSP source for nvim-cmp
Plug 'mhartington/formatter.nvim' "A format runner for neovim, written in lua.
Plug 'Yggdroot/indentLine' "Displaying thin vertical lines at each indentation level for code indented with spaces
call plug#end()
