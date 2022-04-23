(module dotfiles.plugin.toggleterm
  {autoload {toggleterm toggleterm}})

(toggleterm.setup {:open_mapping "<leader>tt"
                   :direction "float"})
