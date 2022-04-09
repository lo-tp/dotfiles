-- be iMproved, required
vim.opt.compatible=false

-- plugins managened by vim-plug
vim.api.nvim_command([[
  runtime ./plugin.vim
]])

function configEncoding()
  vim.opt.encoding='utf-8' 
end

function configLineNumber()
  --turn line number
  vim.opt.number=true 
  --turn on relative line number
  vim.opt.relativenumber=true 
end

function configClipboard()
  --use system clipboard
  vim.opt.clipboard='unnamed' 
end

function configPythonPath()
  -- python support for neo vim
  vim.g.python_host_prog = '/usr/local/bin/python2'
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end

function configQueryHighlight()
  -- turn off query highlight by default
  vim.opt.hls=false
end

function configAckPlugin()
  -- use ag to do file content search
  if vim.fn.executable('ag') then
    vim.g.ackprg = 'ag --vimgrep'
  end
end

function configIndentLinePlugin()
  vim.g.indentLine_color_term = 47
  vim.g.indentLine_char = '┆'
end

function configPersistentEditingHistory()
  os.execute("mkdir /tmp/.vim-undo-dir")
  vim.opt.undodir="/tmp/.vim-undo-dir"
  vim.opt.undofile=true
end

function configListChar()
  vim.opt.list=true
  --use ⏎ to show end of line in the cursor line
  vim.opt.listchars={eol='⏎'}
end

function configAirlinePlugin()
  vim.g.airline_theme='angr'
end

function configTabooPlugin()
  vim.g.taboo_tab_format='  %N: %P  |'
end

function configTabInput()
  -- tab relevant config
  -- show existing tab with 4 spaces width
  vim.opt.tabstop=2
  -- when indenting with '>', use 4 spaces width
  vim.opt.shiftwidth=2
  -- On pressing tab, insert 4 spaces
  vim.opt.expandtab=true
end

function configVimChoosewinPlugin() 
  --vim-choosewin plugin config
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
end

function addCursorLineInEditingMode()
  vim.opt.cul=true
  vim.api.nvim_command([[
    autocmd InsertEnter * set cursorcolumn
    autocmd InsertLeave * set nocursorcolumn
  ]])
end

function configMainColor()
  vim.g.gruvbox_contrast_dark = 'hard'
  vim.api.nvim_command([[
    colorscheme gruvbox
    highlight Normal  ctermbg=239
    highlight clear LineNr
    highlight CursorLineNr ctermbg=243 
    highlight CursorLine cterm=NONE ctermbg=243 ctermfg=lightgreen
  ]])
end

function configSelectedColorInVisualMode()
  vim.api.nvim_command([[
    highlight Visual cterm=NONE ctermbg=green ctermfg=red
  ]])
end

function configTablineColor()
  vim.api.nvim_command([[
     highlight TabLine      ctermfg=White  ctermbg=239     cterm=NONE
     highlight TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
  ]])
end

function setReactTypeScriptFileType()
  vim.api.nvim_command([[
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.react
  ]])
end

configEncoding()
configLineNumber()
configClipboard()
configPythonPath()
configQueryHighlight()
configAckPlugin()
configIndentLinePlugin()
configPersistentEditingHistory()
configListChar()
configAirlinePlugin()
configTabooPlugin()
configTabInput()
configVimChoosewinPlugin()
addCursorLineInEditingMode()
configSelectedColorInVisualMode()
configMainColor()
configTablineColor()
setReactTypeScriptFileType()

require('keymapping')
