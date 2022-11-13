-- :fennel:1668273976
local install_path = vim.fn.stdpath("data")
local packer_bootstrap = nil
if not vim.fn.isdirectory(install_path) then
  local git_cmd = {"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path}
  packer_bootstrap = vim.fn.system(git_cmd)
  vim.cmd("packadd packer.nvim")
else
end
local packer = require("packer")
local plugins = {{"wbthomason/packer.nvim"}, {"lewis6991/impatient.nvim"}, {"nvim-lua/plenary.nvim"}, {"hrsh7th/nvim-cmp"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-nvim-lsp-signature-help"}, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-cmdline"}, {"L3MON4D3/LuaSnip"}, {"saadparwaiz1/cmp_luasnip"}, {"rafamadriz/friendly-snippets"}, {"neovim/nvim-lspconfig"}, {"folke/neodev.nvim"}, {"jose-elias-alvarez/typescript.nvim"}, {"simrat39/rust-tools.nvim"}, {"williamboman/mason.nvim"}, {"williamboman/mason-lspconfig.nvim"}, {"b0o/schemastore.nvim"}, {"mfussenegger/nvim-jdtls"}, {"mfussenegger/nvim-lint"}, {"mhartington/formatter.nvim"}, {run = ":TSUpdate", "nvim-treesitter/nvim-treesitter"}, {"windwp/nvim-ts-autotag"}, {"p00f/nvim-ts-rainbow"}, {"JoosepAlviste/nvim-ts-context-commentstring"}, {"nvim-treesitter/nvim-treesitter-context"}, {"nvim-treesitter/nvim-treesitter-textobjects"}, {"nvim-telescope/telescope.nvim"}, {"nvim-telescope/telescope-ui-select.nvim"}, {"nvim-telescope/telescope-file-browser.nvim"}, {"akinsho/toggleterm.nvim"}, {"windwp/nvim-autopairs"}, {"kylechui/nvim-surround"}, {"gpanders/editorconfig.nvim"}, {"lewis6991/gitsigns.nvim"}, {"kyazdani42/nvim-web-devicons"}, {"folke/tokyonight.nvim"}, {"rcarriga/nvim-notify"}, {"nvim-lualine/lualine.nvim"}, {"numToStr/Comment.nvim"}, {"norcalli/nvim-colorizer.lua"}, {"lukas-reineke/indent-blankline.nvim"}, {"ggandor/lightspeed.nvim"}, {tag = "v3.*", "akinsho/bufferline.nvim"}, {"https://git.sr.ht/~whynothugo/lsp_lines.nvim"}, {"folke/trouble.nvim"}, {"gbprod/phpactor.nvim"}, {"udayvir-singh/tangerine.nvim"}, {"wakatime/vim-wakatime"}}
local function _2_(use)
  _G.assert((nil ~= use), "Missing argument use on plugins.fnl:125")
  for _, plugin in ipairs(plugins) do
    use(plugin)
  end
  if packer_bootstrap then
    return packer.sync()
  else
    return nil
  end
end
return packer.startup(_2_)