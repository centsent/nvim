-- :fennel:1668265415
local function set_option(option, value)
  return vim.api.nvim_set_option(option, value)
end
local function create_augroup(name)
  return vim.api.nvim_create_augroup(name, {clear = true})
end
local function with(func)
  local function _1_()
    return func()
  end
  return _1_
end
local function get_servers()
  return {"bashls", "ccls", "clangd", "csharp_ls", "cssls", "cmake", "dockerls", "gopls", "html", "jsonls", "julials", "marksman", "phpactor", "pyright", "rust_analyzer", "solargraph", "sumneko_lua", "taplo", "tsserver", "vimls", "volar", "yamlls"}
end
local function buf_formatting()
  local formatter = (require("utils")).get_formatter
  if not formatter then
    return vim.lsp.buf.format({async = true})
  else
    return nil
  end
end
local function format_on_save(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    local augroup = create_augroup("LspFormatting")
    return vim.api.nvim_create_autocmd("BufWritePost", {group = augroup, buffer = bufnr, callback = buf_formatting})
  else
    return nil
  end
end
local function show_diagnostic_on_focus(client, bufnr)
  set_option("updatetime", 300)
  local augroup = create_augroup("LspDiagnostic")
  local function _4_()
    return vim.diagnostic.open_float(nil, {focusable = false})
  end
  vim.api.nvim_create_autocmd("CursorHold", {group = augroup, buffer = bufnr, callback = _4_})
  return set_option("signcolumn", "yes")
end
local function document_highlight(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local augroup = create_augroup("LspDocumentHighlight")
    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {group = augroup, buffer = bufnr, callback = with(vim.lsp.buf.document_highlight)})
    return vim.api.nvim_create_autocmd("CursorMoved", {group = augroup, buffer = bufnr, callback = with(vim.lsp.buf.clear_references)})
  else
    return nil
  end
end
local function set_keymaps(bufnr)
  local bufopts = {noremap = true, silent = true, buffer = bufnr}
  local keymaps = {ga = with(vim.lsp.buf.code_action), gd = with(vim.lsp.buf.definition), gi = with(vim.lsp.buf.implementation), gr = with(vim.lsp.buf.rename), gtd = with(vim.lsp.buf.type_definition), gh = with(vim.lsp.buf.hover), gn = with(vim.diagnostic.goto_next), gp = with(vim.diagnostic.goto_prev)}
  return (require("keymaps")).load_keymaps_for_mode("n", keymaps, bufopts)
end
local function on_attach(client, bufnr)
  set_keymaps(bufnr)
  show_diagnostic_on_focus(client, bufnr)
  format_on_save(client, bufnr)
  return document_highlight(client, bufnr)
end
local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_3f, cmp = pcall(require, "cmp_nvim_lsp")
  if has_cmp_3f then
    capabilities = cmp.default_capabilities(capabilities)
    return nil
  else
    return nil
  end
end
local signs = {Error = "\239\153\153 ", Warn = "\239\148\169 ", Hint = "\239\160\181 ", Info = "\239\145\137 "}
local function setup_signs()
  for type, icon in pairs(signs) do
    local hl = ("DiagnosticSign" .. type)
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
  end
  return nil
end
return {signs = signs, setup_signs = setup_signs, get_servers = get_servers, on_attach = on_attach}