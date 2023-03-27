(import-macros {: not-nil! : g! : each!} :macros)

(g! :mapleader ",")

(local mode-adapters {:normal-mode :n
                      :visual-mode :v
                      :visual-block-mode :x
                      :insert-mode :i
                      :operator-pending-mode :o})

(local normal-mode {;; Map <space> to / (search)
                    :<space> "/"
                    ;; Disable arrow keys
                    :<left> :<nop>
                    :<right> :<nop>
                    :<up> :<nop>
                    :<down> :<nop>
                    ;; ex mode commands made easy
                    ";" ":"
                    ;; Don't highlight search result
                    :<leader>/ ":nohlsearch<cr>"
                    ;; Fast saving
                    :<leader>w ":w!<cr>"
                    ;; Quickly close the current window/buffer
                    :<leader>q ":q<cr>"
                    ;; Quickly close the current window/buffer without reminder
                    :<leader>a ":q!<cr>"
                    ;; Remap U to <c-r> for easier undo
                    :U :<c-r>
                    ;; Go to home and end using capitalized directions
                    :H "^"
                    :L "$"
                    ;; Scroll smoothly
                    :<c-d> :<c-d>zz
                    :<c-u> :<c-u>zz
                    :n :nzz
                    :N :Nzz
                    ;; Move a line of text up and down
                    :<c-j> ":move +1<cr>"
                    :<c-k> ":move -2<cr>"
                    ;; Use tab for circular windows navigation
                    :<tab> :<c-w>w
                    ;; Mappings for managing tabs
                    ;; Open a new tab
                    :tt ":tabnew<cr>"
                    ;; Navigate to previous tab
                    :tp ":tabprevious<cr>"
                    ;; Navigate to next tab
                    :tn ":tabnext<cr>"
                    ;; New horizontal split(editing current buffer)
                    :<space>1 :<c-w>s
                    ;; Split window vertically(editing current buffer)
                    :<space>2 :<c-w>v})

(local visual-mode {:<leader>y "\"+y"
                    ;; Paste from clipboard
                    :<leader>p "\"+p"
                    ;; Cut to clipboard
                    :<leader>x "\"+d"
                    ;; Go to home and end using capitalized directions
                    :H "^"
                    :L "$"})

(local insert-mode {;; Use <c-c> for escaping
                    :<c-c> :<esc>
                    ;; Directions in insert mode
                    :<c-b> :<c-o>h
                    :<c-f> :<c-o>l
                    ;; Go to next line
                    :<c-n> :<c-o>j
                    ;; Go to previous line
                    :<c-p> :<c-o>k
                    ;; Go to home
                    :<c-a> :<c-o>^
                    ;; Go to end
                    :<c-e> :<c-o>$
                    ;; Scroll up
                    :<c-u> "<c-\\><c-o><c-u>"
                    ;; Scroll down
                    :<c-d> "<c-\\><c-o><c-d>"})

(local visual-block-mode
       {;; Move selected lines up/down
        :<c-j> ":move '>+1<cr>gv-gv"
        :<c-k> ":move '<-2<cr>gv-gv"})

(local default-keymaps
       {: normal-mode
        : visual-mode
        : visual-block-mode
        : insert-mode
        :operator-pending-mode {:H "^" :L "$"}})

(fn load-mode [mode_key keymaps]
  (local mode (. mode-adapters mode_key))
  (when (not-nil! mode)
    (each! keymaps (fn [from to]
                     (vim.keymap.set mode from to)))))

(fn load-keymaps [keymaps]
  (each [mode-key mode-keymaps (pairs keymaps)]
    (load-mode mode-key mode-keymaps)))

(load-keymaps default-keymaps)

