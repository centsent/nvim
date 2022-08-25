local set_keymap = vim.keymap.set

-- Mapping a key in Normal Mode
local function nmap(from, to)
  set_keymap("n", from, to)
end

-- Mapping a key in Insert Mode
local function imap(from, to)
  set_keymap("i", from, to)
end

-- Mapping a key in Visual Mode
local function vmap(from, to)
  set_keymap("v", from, to)
end

-- Mapping a key in Visual Block Mode
local function xmap(from, to)
  set_keymap("x", from, to)
end

-- Map leader key to comma
vim.g.mapleader = ","

-- Map <space> to / (search)
nmap("<space>", "/")

-- Disable arrow keys
nmap("<left>", "<nop>")
nmap("<right>", "<nop>")
nmap("<up>", "<nop>")
nmap("<down>", "<nop>")

-- ex mode commands made easy
nmap(";", ":")

-- Don't highlight search result
nmap("<leader>/", ":nohlsearch<cr>")

-- Fast saving
nmap("<leader>w", ":w!<cr>")
-- Quickly close the current window/buffer
nmap("<leader>q", ":q<cr>")
-- Quickly close the current window/buffer without reminder
nmap("<leader>a", ":q!<cr>")
-- Toggle netrw
nmap("<leader>f", ":Lex<cr>")

-- Remap U to <c-r> for easier undo
nmap("U", "<c-r>")

-- Go to home and end using capitalized directions
nmap("H", "^")
nmap("L", "$")

-- Move a line of text up and down
nmap("<c-j>", ":move +1<cr>")
nmap("<c-k>", ":move -2<cr>")

-- Use tab for circular windows navigation
nmap("<tab>", "<c-w>w")

-- Mappings for managing tabs
-- Open a new tab
nmap("tt", ":tabnew<cr>")
-- Navigate to previous tab
nmap("tp", ":tabprevious<cr>")
-- Navigate to next tab
nmap("tn", ":tabnext<cr>")

-- New horizontal split(editing current buffer)
nmap("<space>1", "<c-w>s")
-- Split window vertically(editing current buffer)
nmap("<space>2", "<c-w>v")

-- Copy to clipboard
vmap("<leader>y", '"+y')
-- Paste from clipboard
vmap("<leader>p", '"+p')
-- Cut to clipboard
vmap("<leader>x", '"+d')
-- Go to home and end using capitalized directions
vmap("H", "^")
vmap("L", "$")

-- Move text up and down
xmap("<c-j>", ":move '>+1<CR>gv-gv")
xmap("<c-k>", ":move '<-2<CR>gv-gv")

-- Use <c-j> for escaping
imap("<c-j>", "<esc>")

-- Directions in insert mode
imap("<c-b>", "<c-o>h")
imap("<c-f>", "<c-o>l")
-- Go to next line
imap("<c-n>", "<c-o>j")
-- Go to previous line
imap("<c-p>", "<c-o>k")
-- Go to home
imap("<c-a>", "<c-o>^")
-- Go to end
imap("<c-e>", "<c-o>$")
-- Scroll up
imap("<c-u>", "<c-\\><c-o><c-u>")
-- Scroll down
imap("<c-d>", "<c-\\><c-o><c-d>")
