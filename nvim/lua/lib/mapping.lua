local function map (mode, shortcut, command, option)
  vim.api.nvim_set_keymap(
    mode,
    shortcut,
    command,
    option
   )
end
    
    
mapping = {
  map = map,
}

return mapping
