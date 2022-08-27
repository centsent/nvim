local has_toggleterm, toggleterm = pcall(require, "toggleterm")
if not has_toggleterm then
  return
end

local Terminal = require("toggleterm.terminal").Terminal

toggleterm.setup({
  open_mapping = "<leader>tt",
  direction = "float",
})

local make_lazygit_terminal = function()
  return Terminal:new({
    cmd = "lazygit",
    direction = "float",
    float_opts = {
      border = "curved",
    },
  })
end

local setup_lazygit_terminal = function()
  local lazygit_terminal = make_lazygit_terminal()
  local toggle_lazygit = function()
    lazygit_terminal:toggle()
  end
  -- bind a key to toggle lazygit terminal
  vim.keymap.set("n", "<leader>tg", toggle_lazygit)
end

if vim.fn.executable("lazygit") == 1 then
  setup_lazygit_terminal()
end
