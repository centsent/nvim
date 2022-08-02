(module dotfiles.plugin
  {autoload {a aniseed.core
             packer packer}})

(defn- safe-require-plugin-config [name]
  "Safely require a module under the dotfiles.plugin.* prefix. Will catch errors
  and print them while continuing execution, allowing other plugins to load
  even if one configuration module is broken."
  (let [(ok? val-or-err) (pcall require (.. "dotfiles.plugin." name))]
    (when (not ok?)
      (print (.. "Plugin config error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well.
  This is just a helper / syntax sugar function to make interacting with packer
  a little more concise."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name))))

        (if _G.packer_bootstrap
          (packer.sync)))))


  nil)


;; Plugins to be managed by packer.
(use
  ; use-package inspired plugin/package management for Neovim.
  :wbthomason/packer.nvim {}

  ; Neovim configuration and plugins in Fennel (Lisp compiled to Lua).
  :Olical/aniseed {}

  ; A completion engine plugin for neovim written in Lua.
  :hrsh7th/nvim-cmp {:mod :nvim-cmp :requires [[:L3MON4D3/LuaSnip] 
                                               [:hrsh7th/cmp-nvim-lsp] 
                                               [:hrsh7th/cmp-path]
                                               [:hrsh7th/cmp-buffer]
                                               [:saadparwaiz1/cmp_luasnip]
                                               [:rafamadriz/friendly-snippets]]}

  ; A collection of common configurations for Neovim's built-in language server client.
  :neovim/nvim-lspconfig {:mod :lspconfig}

  ;An asynchronous linter plugin for Neovim
  :mfussenegger/nvim-lint {:mod :nvim-lint}

  ; telescope.nvim is a highly extendable fuzzy finder over lists.
  :nvim-telescope/telescope.nvim {:mod :telescope :requires [[:nvim-lua/plenary.nvim]]}

  ; A git wrapper for vim.
  :tpope/vim-fugitive {}

  ; Insert or delete brackets, parens, quotes in pair.
  :jiangmiao/auto-pairs {}

  ; Comment functions so powerful-no comment necessary.
  :preservim/nerdcommenter {}

  ; EditorConfig plugin for Neovim written in Fennel.
  :gpanders/editorconfig.nvim {}

  ; `gS` to split a one-liner into multiple lines
  ; `gJ` (with the cursor on the first line) to join a block into a single line statement.
  :AndrewRadev/splitjoin.vim {}

  ; Delete/change/add parentheses/quotes/XML-tags/much more with ease.
  :tpope/vim-surround {}

  ; Breakdown Vim's --startuptime output.
  :tweekmonster/startuptime.vim {}

  ; A port of Material colorscheme for NeoVim written in Lua.
  :marko-cerovac/material.nvim {:mod :material}

  ; A neovim lua plugin to help easily manage multiple terminal windows
  :akinsho/toggleterm.nvim {:mod :toggleterm}

  ; For my own use,
  ; If you use my nvim-config, please comment out the following line.
  :wakatime/vim-wakatime {}

  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate" :mod :treesitter}
  )
