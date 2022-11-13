-- :fennel:1668269448
vim.g.mapleader = ","
local mode_adapters = {normal_mode = "n", visual_mode = "v", visual_block_mode = "x", insert_mode = "i", operator_pending_mode = "o"}
local default_keymaps = {normal_mode = {["<space>"] = "/", ["<left>"] = "<nop>", ["<right>"] = "<nop>", ["<up>"] = "<nop>", ["<down>"] = "<nop>", [";"] = ":", ["<leader>/"] = ":nohlsearch<cr>", ["<leader>w"] = ":w!<cr>", ["<leader>q"] = ":q<cr>", ["<leader>a"] = ":q!<cr>", ["<leader>f"] = ":Lex<cr>", U = "<c-r>", H = "^", L = "$", ["<c-j>"] = ":move +1<cr>", ["<c-k>"] = ":move -2<cr>", ["<tab>"] = "<c-w>w", tt = ":tabnew<cr>", tp = ":tabprevious<cr>", tn = ":tabnext<cr>", ["<space>1"] = "<c-w>s", ["<space>2"] = "<c-w>v"}, visual_mode = {["<leader>y"] = "\"+y", ["<leader>p"] = "\"+p", ["<leader>x"] = "\"+d", H = "^", L = "$"}, visual_block_mode = {["<c-j>"] = ":move '>+1<cr>gv-gv", ["<c-k>"] = ":move '<-2<cr>gv-gv"}, insert_mode = {["<c-j>"] = "<esc>", ["<c-b>"] = "<c-o>h", ["<c-f>"] = "<c-o>l", ["<c-n>"] = "<c-o>j", ["<c-p>"] = "<c-o>k", ["<c-a>"] = "<c-o>^", ["<c-e>"] = "<c-o>$", ["<c-u>"] = "<c-\\><c-o><c-u>", ["<c-d>"] = "<c-\\><c-o><c-d>"}, operator_pending_mode = {H = "^", L = "$"}}
local function load_mode(mode_key, keymaps)
  local mode = mode_adapters[mode_key]
  if (mode ~= nil) then
    for from, to in pairs(keymaps) do
      vim.keymap.set(mode, from, to)
    end
    return nil
  else
    return nil
  end
end
local function load_keymaps(keymaps)
  for mode_key, mode_keymaps in pairs(keymaps) do
    load_mode(mode_key, mode_keymaps)
  end
  return nil
end
local function load_keymaps_for_mode(mode, keymaps, opts)
  if ((mode ~= nil) and (keymaps ~= nil)) then
    for from, to in pairs(keymaps) do
      vim.keymap.set(mode, from, to, opts)
    end
    return nil
  else
    return nil
  end
end
load_keymaps(default_keymaps)
return {load_keymaps = load_keymaps, load_keymaps_for_mode = load_keymaps_for_mode}