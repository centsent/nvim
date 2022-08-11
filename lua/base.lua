vim.cmd("autocmd!")

vim.wo.number = true

-- Set default encoding to UTF-8
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.termencoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.title = true
vim.opt.autoindent = true
-- Show me what I'm typing
vim.opt.showcmd = true
-- No backup
vim.opt.backup = false
-- Prefer Unix over Windows Over MacOS formats
vim.opt.fileformats = "unix,dos,mac"
-- Automatically read changed files
vim.opt.autoread = true
-- Always show current position
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.ruler = true
vim.opt.colorcolumn = "80"
-- highlights
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

vim.opt.cmdheight = 1
vim.opt.laststatus = 2

vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- Making the background transparent
vim.cmd("autocmd ColorScheme * highlight Normal ctermbg=none guibg=none")

-- Enter automatically into the files directory
vim.api.nvim_create_autocmd({ "BufEnter" }, { command = "silent! lcd %:p:h" })
