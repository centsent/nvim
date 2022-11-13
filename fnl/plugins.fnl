(local install_path (vim.fn.stdpath "data"))
(var packer_bootstrap nil)

(when (not (vim.fn.isdirectory install_path))
  (local git_cmd [
    "git"
    "clone"
    "--depth"
    "1"
    "https://github.com/wbthomason/packer.nvim"
    install_path
  ])
  (set packer_bootstrap (vim.fn.system git_cmd))
  (vim.cmd "packadd packer.nvim"))

(local packer (require :packer))
(local plugins [
  ; A use-package inspired plugin manager for Neovim.
  ["wbthomason/packer.nvim"]
  ; Speed up loading Lua modules in Neovim to improve startup time.
  ["lewis6991/impatient.nvim"]
  ; All the lua functions I don't want to write twice.
  ["nvim-lua/plenary.nvim"]
  ; A completion plugin for neovim coded in Lua.
  ["hrsh7th/nvim-cmp"]
  ; nvim-cmp source for buffer words
  ["hrsh7th/cmp-buffer"]
  ; nvim-cmp source for neovim builtin LSP client
  ["hrsh7th/cmp-nvim-lsp"]
  ; nvim-cmp source for displaying function signatures with the current parameter emphasized:
  ["hrsh7th/cmp-nvim-lsp-signature-help"]
  ; nvim-cmp source for path
  ["hrsh7th/cmp-path"]
  ; nvim-cmp source for vim's cmdline
  ["hrsh7th/cmp-cmdline"]
  ; Snippet Engine for Neovim written in Lua.
  ["L3MON4D3/LuaSnip"]
  ; luasnip completion source for nvim-cmp
  ["saadparwaiz1/cmp_luasnip"]
  ; Set of preconfigured snippets for different languages.
  ["rafamadriz/friendly-snippets"]
  ; Configs for neovim lsp client
  ["neovim/nvim-lspconfig"]
  ; Dev setup for init.lua and plugin development with full signature help docs and completion for the nvim lua API.
  ["folke/neodev.nvim"]
  ; A Lua plugin written in TypeScript to write TypeScript (Lua optional).
  ["jose-elias-alvarez/typescript.nvim"]
  ; A plugin to improve your rust experience in neovim.
  ["simrat39/rust-tools.nvim"]
  ; Portable package manager for Neovim that runs everywhere Neovim runs.
  ["williamboman/mason.nvim"]
  ; Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
  ["williamboman/mason-lspconfig.nvim"]
  ; JSON schemas for Neovim
  ["b0o/schemastore.nvim"]
  ; Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls
  ["mfussenegger/nvim-jdtls"]
  ; An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
  ["mfussenegger/nvim-lint"]
  ; Opt-in formatters
  ["mhartington/formatter.nvim"]
  ; Nvim Treesitter configurations and abstraction layer
  {
    1 "nvim-treesitter/nvim-treesitter"
    :run ":TSUpdate"
  }
  ; Use treesitter to autoclose and autorename html tag
  ["windwp/nvim-ts-autotag"]
  ; Rainbow parentheses for neovim using tree-sitter
  ["p00f/nvim-ts-rainbow"]
  ; Neovim treesitter plugin for setting the commentstring based on the cursor location in a file
  ["JoosepAlviste/nvim-ts-context-commentstring"]
  ; Show code context
  ["nvim-treesitter/nvim-treesitter-context"]
  ; Syntax aware text-objects select move swap and peek support.
  ["nvim-treesitter/nvim-treesitter-textobjects"]
  ; Find Filter Preview Pick. All lua all the time.
  ["nvim-telescope/telescope.nvim"]
  ; It sets vim.ui.select to telescope. That means for example that neovim core stuff can fill the telescope picker
  ["nvim-telescope/telescope-ui-select.nvim"]
  ; File Browser extension for telescope.nvim
  ["nvim-telescope/telescope-file-browser.nvim"]
  ; A neovim lua plugin to help easily manage multiple terminal windows
  ["akinsho/toggleterm.nvim"]
  ; A super powerful autopair plugin for Neovim that supports multiple characters
  ["windwp/nvim-autopairs"]
  ; Add/change/delete surrounding delimiter pairs with ease.
  ["kylechui/nvim-surround"]
  ; EditorConfig plugin for Neovim
  ["gpanders/editorconfig.nvim"]
  ; Git integration for buffers
  ["lewis6991/gitsigns.nvim"]
  ; lua `fork` of vim-web-devicons for neovim
  ["kyazdani42/nvim-web-devicons"]
  ; A clean dark Neovim theme written in Lua with support for lsp treesitter and lots of plugins
  ["folke/tokyonight.nvim"]
  ; A fancy configurable notification manager for NeoVim
  ["rcarriga/nvim-notify"]
  ; A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  ["nvim-lualine/lualine.nvim"]
  ; Smart and powerful comment plugin for neovim
  ["numToStr/Comment.nvim"]
  ; The fastest Neovim colorizer.
  ["norcalli/nvim-colorizer.lua"]
  ; Indent guides for Neovim
  ["lukas-reineke/indent-blankline.nvim"]
  ; Next-generation motion plugin using incremental input processing
  ["ggandor/lightspeed.nvim"]
  ; A snazzy bufferline for Neovim
  { 1 "akinsho/bufferline.nvim" :tag "v3.*" }
  ; lsp_lines is a simple neovim plugin that renders diagnostics using virtual lines on top of the real line of code.
  ["https://git.sr.ht/~whynothugo/lsp_lines.nvim"]
  ; A pretty list for showing diagnostics references telescope results quickfix and location lists to help you solve all the trouble your code is causing.
  ["folke/trouble.nvim"]
  ; Lua version of phpactor nvim plugin
  ["gbprod/phpactor.nvim"]
  ; Sweet Fennel integration for Neovim
  ["udayvir-singh/tangerine.nvim"]
  ; LSP signature hint as you type
  ["ray-x/lsp_signature.nvim"]
  ; Standalone UI for nvim-lsp progress
  ["j-hui/fidget.nvim"]
  ; Simple winbar/statusline plugin that shows your current code context
  ["SmiteshP/nvim-navic"]

  ; For my personal use only
  ; The open source plugin for productivity metrics goals leaderboards and automatic time tracking.
  ["wakatime/vim-wakatime"]

  ])

(packer.startup (lambda [use]
  (each [_ plugin (ipairs plugins)]
    (use plugin))
  (when packer_bootstrap
    (packer.sync))))
