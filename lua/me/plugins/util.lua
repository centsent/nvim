-- :fennel:1679213267
local function make_lazygit_terminal()
  local _local_1_ = require("toggleterm.terminal")
  local Terminal = _local_1_["Terminal"]
  return Terminal:new({cmd = "lazygit", direction = "float", float_opts = {border = "curved"}})
end
local function toggle_lazygit_terminal()
  local lazygit_terminal = make_lazygit_terminal()
  return lazygit_terminal:toggle()
end
local function _2_()
  return toggle_lazygit_terminal()
end
local function _3_()
  vim.g.startuptime_tries = 10
  return nil
end
return {{opts = {direction = "float"}, keys = {{desc = "Toggle terminal", "<leader>tt", ":ToggleTerm<cr>"}, {desc = "Toggle lazygit terminal", "<leader>tg", _2_}}, "akinsho/toggleterm.nvim"}, {cmd = "StartupTime", config = _3_, "dstein64/vim-startuptime"}, {cmd = {DiffviewOpen = "DiffviewClose", DiffviewToggleFiles = "DiffviewFocusFiles"}, config = true, keys = {{desc = "DiffView", "<leader>gd", "<cmd>DiffviewOpen<cr>"}}, "sindrets/diffview.nvim"}, {lazy = true, "nvim-lua/plenary.nvim"}, {event = {"CursorMoved"}, "wakatime/vim-wakatime"}}