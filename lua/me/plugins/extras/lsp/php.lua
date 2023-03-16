-- :fennel:1678891317
local function setup_phpactor(_, opts)
  local phpactor = require("phpactor")
  local phpactor_path = (vim.fn.stdpath("data") .. "/mason/packages/phpactor")
  local settings = {install = {path = phpactor_path, bin = (phpactor_path .. "/bin/phpactor")}, lspconfig = {options = opts}}
  return phpactor.setup(settings)
end
return {dependencies = {"gbprod/phpactor.nvim"}, opts = {phpactor = {}, setup = {phpactor = setup_phpactor}}, "neovim/nvim-lspconfig"}