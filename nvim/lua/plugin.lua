return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig' --A collection of common configurations for Neovim's built-in language server client
  use 'preservim/nerdtree'
  use 'Chiel92/vim-autoformat' --Provide easy code formatting in Vim by integrating existing code formatters.
  use 'mileszs/ack.vim' -- Quick Search File Content
  use 'scrooloose/nerdcommenter'  -- Vim plugin for intensely orgasmic commenting
  use 't9md/vim-choosewin' --Land on window you chose like tmux's 'display-pane'
  use 'gcmt/taboo.vim' --Few utilities for pretty tabs
  use 'junegunn/vim-peekaboo' --Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
  use 'ap/vim-css-color' --Preview colours in source code while editing
  use 'Asheq/close-buffers.vim' --Bdelete several buffers at once
  use 'mattn/emmet-vim' 
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use {'glepnir/lspsaga.nvim',  branch= 'main'} --Lspsaga is light-weight lsp plugin based on neovim built-in lsp with highly a performant UI.
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim' --Gaze deeply into unknown regions using the power of the moon.
  use {'nvim-telescope/telescope-fzf-native.nvim', branch = 'main', run = 'make' } --fzf-native is a c port of fzf. It only covers the algorithm and implements few functions to support calculating the score.
  use { 'hrsh7th/nvim-cmp', branch = 'main'} --Autocompletion plugin
  use { 'hrsh7th/cmp-nvim-lsp',  branch = 'main'} --LSP source for nvim-cmp
  use {'hrsh7th/cmp-buffer', branch = 'main' } --nvim-cmp source for buffer words
  use { 'hrsh7th/cmp-vsnip', branch = 'main'}
  use 'hrsh7th/vim-vsnip'
  use 'mhartington/formatter.nvim' --A format runner for neovim, written in lua.
  use 'Yggdroot/indentLine' --Displaying thin vertical lines at each indentation level for code indented with spaces
  use 'morhetz/gruvbox' --A bright theme with pastel 'retro groove' colors
  use 'liuchengxu/vista.vim' --View and search LSP symbols, tags in Vim/NeoVim.
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} --Nvim Treesitter configurations and abstraction layer
  use 'mfussenegger/nvim-jdtls'
end)
