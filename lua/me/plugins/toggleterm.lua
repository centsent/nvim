-- :fennel:1678528745
local function config(_, opts)
  local toggleterm = require("toggleterm")
  local _local_1_ = require("toggleterm.terminal")
  local Terminal = _local_1_["Terminal"]
  toggleterm.setup(opts)
  local function make_lazygit_terminal()
    return Terminal:new({cmd = "lazygit", direction = "float", float_opts = {border = "curved"}})
  end
  local function setup_lazygit_terminal()
    local lazygit_terminal = make_lazygit_terminal()
    local function _2_()
      return lazygit_terminal:toggle()
    end
    return vim.keymap.set("n", "<leader>tg", _2_)
  end
  if (vim.fn.executable("lazygit") == 1) then
    return setup_lazygit_terminal()
  else
    return nil
  end
end
return {opts = {direction = "float"}, keys = {{desc = "Toggle terminal", "<leader>tt", ":ToggleTerm<cr>"}}, event = {"BufReadPost", "BufNewFile"}, config = config, "akinsho/toggleterm.nvim"}