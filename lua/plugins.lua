local is_directory = require("utils").is_directory
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil

if not is_directory(install_path) then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd("packadd packer.nvim")
end

local packer = require("packer")
local plugins = {
  -- A use-package inspired plugin manager for Neovim.
  { "wbthomason/packer.nvim" },
  -- Speed up loading Lua modules in Neovim to improve startup time.
  { "lewis6991/impatient.nvim" },
  -- All the lua functions I don't want to write twice.
  { "nvim-lua/plenary.nvim" },
  -- A completion plugin for neovim coded in Lua.
  { "hrsh7th/nvim-cmp" },
  -- nvim-cmp source for buffer words
  { "hrsh7th/cmp-buffer" },
  -- nvim-cmp source for neovim builtin LSP client
  { "hrsh7th/cmp-nvim-lsp" },
  -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  -- nvim-cmp source for path
  { "hrsh7th/cmp-path" },
  -- nvim-cmp source for vim's cmdline
  { "hrsh7th/cmp-cmdline" },
  -- Snippet Engine for Neovim written in Lua.
  { "L3MON4D3/LuaSnip" },
  -- luasnip completion source for nvim-cmp
  { "saadparwaiz1/cmp_luasnip" },
  -- Set of preconfigured snippets for different languages.
  { "rafamadriz/friendly-snippets" },
  -- Configs for neovim lsp client
  { "neovim/nvim-lspconfig" },
  -- Dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
  { "folke/lua-dev.nvim" },
  -- Portable package manager for Neovim that runs everywhere Neovim runs.
  { "williamboman/mason.nvim" },
  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
  { "williamboman/mason-lspconfig.nvim" },
  -- JSON schemas for Neovim
  { "b0o/schemastore.nvim" },
  -- Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls
  { "mfussenegger/nvim-jdtls" },
  -- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
  { "mfussenegger/nvim-lint" },
  -- Opt-in formatters
  { "mhartington/formatter.nvim" },
  -- Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  },
  -- Use treesitter to autoclose and autorename html tag
  { "windwp/nvim-ts-autotag" },
  -- Rainbow parentheses for neovim using tree-sitter
  { "p00f/nvim-ts-rainbow" },
  -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  -- Find, Filter, Preview, Pick. All lua, all the time.
  { "nvim-telescope/telescope.nvim" },
  -- It sets vim.ui.select to telescope. That means for example that neovim core stuff can fill the telescope picker.
  { "nvim-telescope/telescope-ui-select.nvim" },
  -- A neovim lua plugin to help easily manage multiple terminal windows
  { "akinsho/toggleterm.nvim" },
  -- A super powerful autopair plugin for Neovim that supports multiple characters
  { "windwp/nvim-autopairs" },
  -- Add/change/delete surrounding delimiter pairs with ease.
  { "kylechui/nvim-surround" },
  -- EditorConfig plugin for Neovim
  { "gpanders/editorconfig.nvim" },
  -- Vim plugin for intensely nerdy commenting powers
  { "preservim/nerdcommenter" },
  -- Git integration for buffers
  { "lewis6991/gitsigns.nvim" },
  -- lua `fork` of vim-web-devicons for neovim
  { "kyazdani42/nvim-web-devicons" },
  -- A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins.
  { "folke/tokyonight.nvim" },
  -- A fancy, configurable, notification manager for NeoVim
  { "rcarriga/nvim-notify" },

  -- For my personal use only
  -- The open source plugin for productivity metrics, goals, leaderboards, and automatic time tracking.
  { "wakatime/vim-wakatime" },
}

-- source plugins.lua automatically and run PackerSync
local packer_augroup = vim.api.nvim_create_augroup("packer_user_config", {})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = packer_augroup,
  pattern = { "plugins.lua" },
  command = "source <afile> | PackerSync",
})

packer.startup(function(use)
  for _, plugin in ipairs(plugins) do
    use(plugin)
  end

  if packer_bootstrap then
    -- Install the plugins for first usage
    packer.sync()
  end
end)
