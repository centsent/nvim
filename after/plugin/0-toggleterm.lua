-- :fennel:1668308086
local has_toggleterm_3f, toggleterm = pcall(require, "toggleterm")
if has_toggleterm_3f then
  local Terminal = (require("toggleterm.terminal")).Terminal
  toggleterm.setup({open_mapping = "<leader>tt", direction = "float"})
  local function make_lazygit_terminal()
    return Terminal:new({cmd = "lazygit", direction = "float", float_opts = {border = "curved"}})
  end
  local function setup_lazygit_terminal()
    local lazygit_terminal = make_lazygit_terminal()
    local function _1_()
      return lazygit_terminal:toggle()
    end
    return vim.keymap.set("n", "<leader>tg", _1_)
  end
  if (vim.fn.executable("lazygit") == 1) then
    return setup_lazygit_terminal()
  else
    return nil
  end
else
  return nil
end