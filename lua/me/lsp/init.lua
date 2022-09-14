local mylsp = {}

local o = function(option, value)
  vim.api.nvim_set_option(option, value)
end

local with = require("utils").with
local get_formatter = require("utils").get_formatter
local safe_require = require("utils").safe_require
local has_lspconfig, lspconfig = safe_require("lspconfig")

mylsp.get_servers = function()
  return {
    "bashls",
    "ccls",
    "clangd",
    "csharp_ls",
    "cssls",
    "cmake",
    "dockerls",
    "gopls",
    "html",
    "jsonls",
    "julials",
    "marksman",
    "phpactor",
    "pyright",
    "rust_analyzer",
    "solargraph",
    "sumneko_lua",
    "tsserver",
    "vimls",
    "volar",
    "yamlls",
  }
end

local buf_formatting = function()
  local formatter = get_formatter()
  -- fallback to lsp formatting if no formatter defined
  if not formatter then
    vim.lsp.buf.formatting({})
  end
end

local format_on_save = function(client, bufnr)
  -- Format on save if the lsp client supports formatting
  if client.resolved_capabilities.document_formatting then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      buffer = bufnr,
      callback = with(buf_formatting),
    })
  end
end

local show_diagnostic_on_focus = function(_, bufnr)
  -- Set updatetime for CursorHold
  -- 300ms of no cursor movement to trigger CursorHold
  o("updatetime", 300)
  local augroup = vim.api.nvim_create_augroup("LspDiagnostic", { clear = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = false })
    end,
  })

  -- have a fixed column for the diagnostics to appear in
  -- this removes the jitter when warnings/errors flow in
  o("signcolumn", "yes")
end

local set_keymaps = function(_, bufnr)
  local buf_set_keymap = function(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }
  local keymaps = {
    ["gd"] = ":lua vim.lsp.buf.definition()<cr>",
    ["gi"] = ":lua vim.lsp.buf.implementation()<cr>",
    ["gr"] = ":lua vim.lsp.buf.rename()<cr>",
    ["gy"] = ":lua vim.lsp.buf.type_definition()<cr>",
    ["gh"] = ":lua vim.lsp.buf.hover()<cr>",
    ["gn"] = ":lua vim.diagnostic.goto_next()<cr>",
    ["gp"] = ":lua vim.diagnostic.goto_prev()<cr>",
    ["ga"] = ":lua vim.lsp.buf.code_action()<cr>",
  }

  for from, to in pairs(keymaps) do
    buf_set_keymap("n", from, to, opts)
  end
end

mylsp.on_attach = function(client, bufnr)
  set_keymaps(client, bufnr)
  show_diagnostic_on_focus(client, bufnr)
  format_on_save(client, bufnr)
end

mylsp.make_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- Set up completion using nvim_cmp with LSP source
  local has_cmp, cmp = safe_require("cmp_nvim_lsp")
  if has_cmp then
    capabilities = cmp.update_capabilities(capabilities)
  end

  return capabilities
end

mylsp.get_default_config = function()
  return {
    capabilities = mylsp.make_capabilities(),
    on_attach = mylsp.on_attach,
    flags = { debounce_text_change = 150 },
  }
end

mylsp.setup_with_config = function(name, config)
  if not has_lspconfig then
    return
  end

  lspconfig[name].setup(vim.tbl_deep_extend("force", mylsp.get_default_config(), config))
end

mylsp.signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

mylsp.setup_signs = function()
  for type, icon in pairs(mylsp.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return mylsp
