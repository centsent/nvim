local set_keymap = vim.keymap.set

local function nmap(from, to)
  set_keymap("n", from, to)
end

local function imap(from, to)
  set_keymap("i", from, to)
end

local function vmap(from, to)
  set_keymap("v", from, to)
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
nmap("<leader>q", ":q!<cr>")

-- Remap U to <c-r> for easier undo
nmap("U", "<c-r>")

-- Go to home and end using capitalized directions
nmap("H", "^")
nmap("L", "$")

-- Move a line of text up and down
nmap("<c-j>", "mz:m+<cr>`z")
nmap("<c-k>", "mz:m-2<cr>`z")

-- Use tab for circular windows navigation
nmap("<tab>", "<c-w>w")

-- Mappings for managing tabs
nmap("tt", ":tabnew<cr>")
nmap("tp", ":tabprevious<cr>")
nmap("tn", ":tabnext<cr>")

-- New horizontal split(editing current buffer)
nmap("<space>1", "<c-w>s")
-- Split window vertically(editing current buffer)
nmap("<space>2", "<c-w>v")

-- Toggle netrw
nmap("<leader>f", ":Lex<cr>")

-- Copy to clipboard
vmap("<leader>y", '"+y')
-- Paste from clipboard
vmap("<leader>p", '"+p')
-- Cut to clipboard
vmap("<leader>x", '"+d')
-- Go to home and end using capitalized directions
vmap("H", "^")
vmap("L", "$")

-- Use <c-j> for escaping and quickly save
imap("<c-j>", "<esc>")

-- Directions in insert mode
imap("<c-b>", "<c-o>h")
imap("<c-n>", "<c-o>j")
imap("<c-p>", "<c-o>k")
imap("<c-f>", "<c-o>l")

-- Go to home
imap("<c-a>", "<c-o>^")
-- Go to end
imap("<c-e>", "<c-o>$")
-- Scroll up
imap("<c-u>", "<c-\\><c-o><c-u>")
-- Scroll down
imap("<c-d>", "<c-\\><c-o><c-d>")
