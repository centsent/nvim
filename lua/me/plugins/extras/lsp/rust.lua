-- :fennel:1679301324
local function setup_rust_analyzer(_, opts)
  local rust_tools = require("rust-tools")
  return rust_tools.setup({server = opts})
end
local function _1_(_, opts)
  do
    local has_cmp_3f, cmp = pcall(require, "cmp")
    if has_cmp_3f then
      cmp.setup.buffer({sources = {{name = "crates"}}})
    else
    end
  end
  return (require("crates")).setup(opts)
end
return {{dependencies = {"simrat39/rust-tools.nvim"}, opts = {rust_analyzer = {}, setup = {rust_analyzer = setup_rust_analyzer}}, "neovim/nvim-lspconfig"}, {event = {"BufRead Cargo.toml"}, config = _1_, "saecki/crates.nvim"}}