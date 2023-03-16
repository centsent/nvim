-- :fennel:1668570020
vim.g.mapleader = ","
local mode_adapters = {normal_mode = "n", visual_mode = "v", visual_block_mode = "x", insert_mode = "i", operator_pending_mode = "o"}
local normal_mode_keymaps = {["<space>"] = "/", ["<left>"] = "<nop>", ["<right>"] = "<nop>", ["<up>"] = "<nop>", ["<down>"] = "<nop>", [";"] = ":", ["<leader>/"] = ":nohlsearch<cr>", ["<leader>w"] = ":w!<cr>", ["<leader>q"] = ":q<cr>", ["<leader>a"] = ":q!<cr>", U = "<c-r>", H = "^", L = "$", ["<c-d>"] = "<c-d>zz", ["<c-u>"] = "<c-u>zz", n = "nzz", N = "Nzz", ["<c-j>"] = ":move +1<cr>", ["<c-k>"] = ":move -2<cr>", ["<tab>"] = "<c-w>w", tt = ":tabnew<cr>", tp = ":tabprevious<cr>", tn = ":tabnext<cr>", ["<space>1"] = "<c-w>s", ["<space>2"] = "<c-w>v"}
local visual_mode_keymaps = {["<leader>y"] = "\"+y", ["<leader>p"] = "\"+p", ["<leader>x"] = "\"+d", H = "^", L = "$"}
local insert_mode_keymaps = {["<c-c>"] = "<esc>", ["<c-b>"] = "<c-o>h", ["<c-f>"] = "<c-o>l", ["<c-n>"] = "<c-o>j", ["<c-p>"] = "<c-o>k", ["<c-a>"] = "<c-o>^", ["<c-e>"] = "<c-o>$", ["<c-u>"] = "<c-\\><c-o><c-u>", ["<c-d>"] = "<c-\\><c-o><c-d>"}
local visual_block_mode_keymaps = {["<c-j>"] = ":move '>+1<cr>gv-gv", ["<c-k>"] = ":move '<-2<cr>gv-gv"}
local default_keymaps = {normal_mode = normal_mode_keymaps, visual_mode = visual_mode_keymaps, visual_block_mode = visual_block_mode_keymaps, insert_mode = insert_mode_keymaps, operator_pending_mode = {H = "^", L = "$"}}
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