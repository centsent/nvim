Neovim configuration written in `Fennel` for my own personal use.

## Keymaps

* Arrow keys has been disabled.
* `,` for `<leader>` key

### Normal Mode

* prefix `t` for Tab Management
	* `tt`: new tab
	* `tn`: next tab
	* `tp`: previouse tab
* prefix `g` for `lspconfig` keymaps
	* `gd`: go to definiton `vim.lsp.buf.definition()`.
	* `gi`: `vim.lsp.buf.implementation()`
	* `gr`: `vim.lsp.buf.rename()`
	* `gy`: `vim.lsp.buf.type_definition()`
	* `gh`: `vim.lsp.buf.hover()`
	* `gn`: `vim.diagnostic.goto_next()`
	* `gp`: `vim.diagnostic.goto_prev()`
	* `ge`: `vim.diagnostic.open_float()`
* prefix `f` for `telescope` keymaps
	* `ff`: list files in current project.
	* `fg`: `Telescope live_grep`
	* `fm`: `Telescope keymaps`
	* `fr`: `Telescope lsp_references`
	* `fd`: `Telescope lsp_document_symbols`
