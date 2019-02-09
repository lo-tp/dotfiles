let g:lsc_enable_autocomplete = v:true
set completeopt-=preview
let g:lsc_auto_map = {
    \ 'GoToDefinition': 'gD',
    \ 'GoToDefinitionSplit': 'gd',
    \ 'FindReferences': 'gr',
    \ 'NextReference': '<C-n>',
    \ 'PreviousReference': '<C-p>',
    \ 'FindImplementations': 'gI',
    \ 'FindCodeActions': 'ga',
    \ 'Rename': 'gR',
    \ 'ShowHover': v:true,
    \ 'DocumentSymbol': 'go',
    \ 'WorkspaceSymbol': 'gS',
    \ 'SignatureHelp': '<C-m>',
    \ 'Completion': 'completefunc',
    \}
