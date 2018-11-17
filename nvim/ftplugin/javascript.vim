nnoremap Y :silent !$(npm bin)/eslint -f compact -c $(npm prefix)/.eslintrc* % --fix >/dev/null 2>&1<CR>
