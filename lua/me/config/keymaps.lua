-- :fennel:1679576214
vim.g["mapleader"] = ","
local mode_adapters = {["normal-mode"] = "n", ["visual-mode"] = "v", ["visual-block-mode"] = "x", ["insert-mode"] = "i", ["operator-pending-mode"] = "o"}
local normal_mode = {["<space>"] = "/", ["<left>"] = "<nop>", ["<right>"] = "<nop>", ["<up>"] = "<nop>", ["<down>"] = "<nop>", [";"] = ":", ["<leader>/"] = ":nohlsearch<cr>", ["<leader>w"] = ":w!<cr>", ["<leader>q"] = ":q<cr>", ["<leader>a"] = ":q!<cr>", U = "<c-r>", H = "^", L = "$", ["<c-d>"] = "<c-d>zz", ["<c-u>"] = "<c-u>zz", n = "nzz", N = "Nzz", ["<c-j>"] = ":move +1<cr>", ["<c-k>"] = ":move -2<cr>", ["<tab>"] = "<c-w>w", tt = ":tabnew<cr>", tp = ":tabprevious<cr>", tn = ":tabnext<cr>", ["<space>1"] = "<c-w>s", ["<space>2"] = "<c-w>v"}
local visual_mode = {["<leader>y"] = "\"+y", ["<leader>p"] = "\"+p", ["<leader>x"] = "\"+d", H = "^", L = "$"}
local insert_mode = {["<c-c>"] = "<esc>", ["<c-b>"] = "<c-o>h", ["<c-f>"] = "<c-o>l", ["<c-n>"] = "<c-o>j", ["<c-p>"] = "<c-o>k", ["<c-a>"] = "<c-o>^", ["<c-e>"] = "<c-o>$", ["<c-u>"] = "<c-\\><c-o><c-u>", ["<c-d>"] = "<c-\\><c-o><c-d>"}
local visual_block_mode = {["<c-j>"] = ":move '>+1<cr>gv-gv", ["<c-k>"] = ":move '<-2<cr>gv-gv"}
local default_keymaps = {["normal-mode"] = normal_mode, ["visual-mode"] = visual_mode, ["visual-block-mode"] = visual_block_mode, ["insert-mode"] = insert_mode, ["operator-pending-mode"] = {H = "^", L = "$"}}
local function load_mode(mode_key, keymaps)
  local mode = mode_adapters[mode_key]
  if (nil ~= mode) then
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
return load_keymaps(default_keymaps)