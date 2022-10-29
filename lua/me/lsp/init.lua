local mylsp = {}
local utils = require("utils")

local o = function(option, value)
  vim.api.nvim_set_option(option, value)
end

local with = utils.with
local get_formatter = utils.get_formatter
local safe_require = utils.safe_require

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
    "taplo",
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
    vim.lsp.buf.format({ async = true })
  end
end

local format_on_save = function(client, bufnr)
  -- Format on save if the lsp client supports formatting
  if not client.server_capabilities.documentFormattingProvider then
    return
  end

  local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup,
    buffer = bufnr,
    callback = with(buf_formatting),
  })
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

local document_highlight = function(client, bufnr)
  if not client.server_capabilities.documentHighlightProvider then
    return
  end

  local augroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = augroup,
    buffer = bufnr,
    callback = with(vim.lsp.buf.document_highlight),
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = augroup,
    buffer = bufnr,
    callback = with(vim.lsp.buf.clear_references),
  })
end

local set_keymaps = function(_, bufnr)
  local buf_set_keymap = function(mode, from, to)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set(mode, from, to, bufopts)
  end

  local keymaps = {
    ["gd"] = with(vim.lsp.buf.definition),
    ["gi"] = with(vim.lsp.buf.implementation),
    ["gr"] = with(vim.lsp.buf.rename),
    ["gtd"] = with(vim.lsp.buf.type_definition),
    ["gh"] = with(vim.lsp.buf.hover),
    ["gn"] = with(vim.diagnostic.goto_next),
    ["gp"] = with(vim.diagnostic.goto_prev),
    ["ga"] = with(vim.lsp.buf.code_action),
  }

  for from, to in pairs(keymaps) do
    buf_set_keymap("n", from, to)
  end
end

mylsp.on_attach = function(client, bufnr)
  set_keymaps(client, bufnr)
  show_diagnostic_on_focus(client, bufnr)
  format_on_save(client, bufnr)
  document_highlight(client, bufnr)
end

mylsp.make_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- Set up completion using nvim_cmp with LSP source
  local has_cmp, cmp = safe_require("cmp_nvim_lsp")
  if has_cmp then
    capabilities = cmp.default_capabilities(capabilities)
  end

  return capabilities
end

mylsp.signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

mylsp.setup_signs = function()
  for type, icon in pairs(mylsp.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return mylsp
