(let [(has-nvim-tree? nvim-tree) (pcall require :nvim-tree)]
  (when has-nvim-tree?
    (set vim.g.loaded_netrw 1)
    (set vim.g.loaded_netrwPlugin 1)
    (local settings {
      :disable_netrw true
    })
    (vim.keymap.set "n" "<leader>f" ":NvimTreeToggle<cr>")

    (nvim-tree.setup settings)))
