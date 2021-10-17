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
