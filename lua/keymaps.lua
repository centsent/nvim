local M = {}

-- Map leader key to comma
vim.g.mapleader = ","

local mode_adapters = {
  normal_mode = "n",
  visual_mode = "v",
  visual_block_mode = "x",
  insert_mode = "i",
}

local default_keymaps = {
  normal_mode = {
    -- Map <space> to / (search)
    ["<space>"] = "/",
    -- Disable arrow keys
    ["<left>"] = "<nop>",
    ["<right>"] = "<nop>",
    ["<up>"] = "<nop>",
    ["<down>"] = "<nop>",
    -- ex mode commands made easy
    [";"] = ":",
    -- Don't highlight search result
    ["<leader>/"] = ":nohlsearch<cr>",
    -- Fast saving
    ["<leader>w"] = ":w!<cr>",
    -- Quickly close the current window/buffer
    ["<leader>q"] = ":q<cr>",
    -- Quickly close the current window/buffer without reminder
    ["<leader>a"] = ":q!<cr>",
    -- Toggle netrw
    ["<leader>f"] = ":Lex<cr>",
    -- Remap U to <c-r> for easier undo
    ["U"] = "<c-r>",
    -- Go to home and end using capitalized directions
    ["H"] = "^",
    ["L"] = "$",
    -- Move a line of text up and down
    ["<c-j>"] = ":move +1<cr>",
    ["<c-k>"] = ":move -2<cr>",
    -- Use tab for circular windows navigation
    ["<tab>"] = "<c-w>w",
    -- Mappings for managing tabs
    -- Open a new tab
    ["tt"] = ":tabnew<cr>",
    -- Navigate to previous tab
    ["tp"] = ":tabprevious<cr>",
    -- Navigate to next tab
    ["tn"] = ":tabnext<cr>",
    -- New horizontal split(editing current buffer)
    ["<space>1"] = "<c-w>s",
    -- Split window vertically(editing current buffer)
    ["<space>2"] = "<c-w>v",
  },
  visual_mode = {
    -- Copy to clipboard
    ["<leader>y"] = '"+y',
    -- Paste from clipboard
    ["<leader>p"] = '"+p',
    -- Cut to clipboard
    ["<leader>x"] = '"+d',
    -- Go to home and end using capitalized directions
    ["H"] = "^",
    ["L"] = "$",
  },
  visual_block_mode = {
    ["<c-j>"] = ":move '>+1<cr>gv-gv",
    ["<c-k>"] = ":move '<-2<cr>gv-gv",
  },
  insert_mode = {
    -- Use <c-j> for escaping
    ["<c-j>"] = "<esc>",
    -- Directions in insert mode
    ["<c-b>"] = "<c-o>h",
    ["<c-f>"] = "<c-o>l",
    -- Go to next line
    ["<c-n>"] = "<c-o>j",
    -- Go to previous line
    ["<c-p>"] = "<c-o>k",
    -- Go to home
    ["<c-a>"] = "<c-o>^",
    -- Go to end
    ["<c-e>"] = "<c-o>$",
    -- Scroll up
    ["<c-u>"] = "<c-\\><c-o><c-u>",
    -- Scroll down
    ["<c-d>"] = "<c-\\><c-o><c-d>",
  },
}

local load_mode = function(mode_key, keymaps)
  local mode = mode_adapters[mode_key] or "n"
  for from, to in pairs(keymaps) do
    vim.keymap.set(mode, from, to)
  end
end

M.load_keymaps = function(keymaps)
  for mode_key, mode_keymaps in pairs(keymaps) do
    load_mode(mode_key, mode_keymaps)
  end
end

M.load_keymaps(default_keymaps)

return M
