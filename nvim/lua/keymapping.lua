-- set leader key
vim.g.mapleader = " "
local map=require('lib.mapping').map
-- Tab Related
map("n","<C-T>", ":tabnew<CR>",{ noremap = true })
map("n", "<c-w>", ":q<cr>", { noremap = true })

-- Window Related
map("n", "<C-H>", "<C-W>h", { noremap = true })
map("n", "<C-L>", "<C-W>l", { noremap = true })
map("n", "<C-K>", "<C-W>k", { noremap = true })
map("n", "<C-J>", "<C-W>j", { noremap = true })
map("n", "<leader>z", ":vsplit<cr>", { noremap = true })
map("n", "<leader>Z", ":split<cr>", { noremap = true })
map("n", "<F1>", ":res -1<cr>", { noremap = true })
map("n", "<F2>", ":res +1<cr>", { noremap = true })
map("n", "<F7>", ":vertical res -1<cr>", { noremap = true })
map("n", "<F8>", ":vertical res +1<cr>", { noremap = true })

-- Buffer Related
map("n", "<leader>O", "<cmd>Telescope buffers<CR>", { noremap = true })

-- bdelete buffers not visible in a window
map("n", "<leader><BS>", ":Bdelete hidden<CR>", { noremap = true })

-- save file
map("n", "<leader>s", ":w<cr>", { noremap = true })
map("n", "<leader>S", ":wa<cr>", { noremap = true })

-- Telescope Find
map("n", "<leader>o", "<cmd>Telescope find_files<cr>", { noremap = true })

-- The-Nerd-Tree
function toggleNerdTree()
  if vim.g.NERDTreeQuitOnOpen == 1
  then
    vim.g.NERDTreeQuitOnOpen = 0
  else
    vim.g.NERDTreeQuitOnOpen = 1
  end
  print(vim.g.NERDTreeQuitOnOpen)
end
map("n", "<leader>w", ":NERDTree<CR>", { noremap = true })
vim.api.nvim_create_user_command(
  'ToggleNerdTree',
  toggleNerdTree,
  {}
)

-- choosewin
map("n", "-", "<Plug>(choosewin)", {})

-- vista.vim
map("n", "<leader>p", ":Vista nvim_lsp<cr>", { noremap = true })

-- save session to $VIM_SESSION if this env veriable exists
local VIM_SESSION = os.getenv('VIM_SESSION')
if VIM_SESSION then
  map("n", "s",  string.format(":mks! %s <cr>", VIM_SESSION), { noremap = true })
end
