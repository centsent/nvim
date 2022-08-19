local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local M = {}

if fn.empty(fn.glob(install_path)) > 0 then
  M.packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd([[packadd packer.nvim]])
end

local packer = require("packer")

packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim")

  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  use("neovim/nvim-lspconfig")
  use("folke/lua-dev.nvim")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  use("b0o/schemastore.nvim")

  use("mfussenegger/nvim-jdtls")
  use("mfussenegger/nvim-lint")
  use("mhartington/formatter.nvim")

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("windwp/nvim-ts-autotag")
  use("p00f/nvim-ts-rainbow")
  use("JoosepAlviste/nvim-ts-context-commentstring")

  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-project.nvim")

  use("akinsho/toggleterm.nvim")

  use("windwp/nvim-autopairs")
  use("tpope/vim-surround")
  use("gpanders/editorconfig.nvim")
  use("preservim/nerdcommenter")

  use("lewis6991/gitsigns.nvim")
  use("kyazdani42/nvim-web-devicons")
  use("folke/tokyonight.nvim")

  use("wakatime/vim-wakatime")

  if M.packer_bootstrap then
    require("packer").sync()
  end
end)
