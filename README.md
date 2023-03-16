## Keymaps

- Arrow keys has been disabled.
- `<space>1`: New horizontal split(editing current buffer)
- `<space>2`: New vertical split(editing current buffer)
- `U`: for easier undo
- `H`: go to beginning of the line
- `L`: go to end of the line
- `<ctrl-j>`: move a line of text down
- `<ctrl-k>`: move a line of text up
- `<tab>`: for circular windows navigation
- Mapped `<space>` to `/`
- Mapped `;` to `:` for easier ex mode commands
- Mapped `,` to `<leader>` key
  - `<leader>w`: Fast saving
  - `<leader>q`: Quickly close the window/buffer
  - `<leader>a`: Quickly close the window/buffer without reminder
  - `<leader>/`: no highlight search
  - `<leader>f`: toggle netwr
  - `<leader>tt`: toggle a float terminal
  - `<leader>tg`: toggle a lazygit terminal
- prefix `t` for Tab Management
  - `tt`: new tab
  - `tn`: next tab
  - `tp`: previous tab
- prefix `g` for `lspconfig` keymaps
  - `gd`: go to definiton `vim.lsp.buf.definition()`.
  - `gi`: `vim.lsp.buf.implementation()`
  - `gr`: `vim.lsp.buf.rename()`
  - `gy`: `vim.lsp.buf.type_definition()`
  - `gh`: `vim.lsp.buf.hover()`
  - `gn`: `vim.diagnostic.goto_next()`
  - `gp`: `vim.diagnostic.goto_prev()`
  - `ge`: `vim.diagnostic.open_float()`
- prefix `f` for `telescope` keymaps
  - `ff`: list files in current project.
  - `fb`: list buffers.
  - `fg`: `Telescope live_grep`
  - `fm`: `Telescope keymaps`
  - `fd`: `Telescope lsp_document_symbols`
  - `fr`: `Telescope lsp_references`

### Visual Mode

- `<leader-y>`: copy to clipboard
- `<leader-p>`: past from clipboard
- `<leader-x>`: cut to clipboard

### Visual Block Mode

- `<c-j>`: move the selected text down
- `<c-k>`: move the selected text up

### Insert Mode

- `<c-j>`: escaping
- `<c-b>`: backward
- `<c-f>`: forward
- `<c-n>`: next line
- `<c-p>`: previous line
- `<c-a>`: go to beginning of the line
- `<c-e>`: go to end of the line
- `<c-u>`: scroll up
- `<c-d>`: scroll down

### Operator Pending Mode

- `H`: go to the beginning of the line
- `L`: go to end of the line
