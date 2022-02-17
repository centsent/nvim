(module dotfiles.core)

(def- command vim.cmd)

;; Prefer Unix over Windows Over MacOS formats
(command "set fileformats=unix,dos,mac")

;; Show line numbers
(command "set number")

;; Show me what I'm typing
(command "set showcmd")

;; Automatically read changed files
(command "set autoread")

;; Enter automatically into the files directory
(command "autocmd BufEnter * silent! lcd %:p:h")

;; When searching try to be smart about cases
(command "set smartcase")

;; Always show current position
(command "
set cursorcolumn
set ruler
set cursorline
set colorcolumn=80
")

;; Turn backup off
(command "
set nobackup
set noswapfile
set nowb
")

;; Enable syntax highlighting
;; Enable filetype plugins
(command "
syntax on
syntax enable
filetype on
filetype plugin on
filetype indent on
filetype plugin indent on
")

;; Set default encoding to UTF-8
(command "
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
")
