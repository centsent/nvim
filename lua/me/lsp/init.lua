-- :fennel:1679045065
local function set_option(option, value)
  return vim.api.nvim_set_option(option, value)
end
local function create_augroup(name)
  return vim.api.nvim_create_augroup(name, {clear = true})
end
local function get_servers()
  return {"bashls", "clangd", "csharp_ls", "cssls", "cmake", "dockerls", "gopls", "html", "jsonls", "julials", "lua_ls", "marksman", "phpactor", "pyright", "rust_analyzer", "solargraph", "taplo", "tsserver", "vimls", "volar", "yamlls"}
end
local function buf_formatting()
  local _local_1_ = require("me.util")
  local get_formatter = _local_1_["get-formatter"]
  local formatter = get_formatter()
  if not formatter then
    return vim.lsp.buf.format({async = true})
  else
    return nil
  end
end
local function format_on_save(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    local events = "BufWritePost"
    local augroup = create_augroup("LspFormatting")
    local opts
    local function _3_()
      return buf_formatting()
    end
    opts = {group = augroup, buffer = bufnr, callback = _3_}
    return vim.api.nvim_create_autocmd(events, opts)
  else
    return nil
  end
end
local function open_diagnostic_float()
  return vim.diagnostic.open_float(nil, {focusable = false})
end
local function show_diagnostic_on_focus(client, bufnr)
  set_option("updatetime", 300)
  local augroup = create_augroup("LspDiagnostic")
  vim.api.nvim_create_autocmd("CursorHold", {group = augroup, buffer = bufnr, callback = open_diagnostic_float})
  return set_option("signcolumn", "yes")
end
local function document_highlight(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local augroup = create_augroup("LspDocumentHighlight")
    local function _5_()
      return vim.lsp.buf.document_highlight()
    end
    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {group = augroup, buffer = bufnr, callback = _5_})
    local function _6_()
      return vim.lsp.buf.clear_references()
    end
    return vim.api.nvim_create_autocmd("CursorMoved", {group = augroup, buffer = bufnr, callback = _6_})
  else
    return nil
  end
end
local function set_keymaps(bufnr)
  local bufopts = {noremap = true, silent = true, buffer = bufnr}
  local keymaps
  local function _8_()
    return vim.lsp.buf.code_action()
  end
  local function _9_()
    return vim.lsp.buf.definition()
  end
  local function _10_()
    return vim.lsp.buf.implementation()
  end
  local function _11_()
    return vim.lsp.buf.rename()
  end
  local function _12_()
    return vim.lsp.buf.type_definition()
  end
  local function _13_()
    return vim.lsp.buf.hover()
  end
  local function _14_()
    return vim.diagnostic.goto_next()
  end
  local function _15_()
    return vim.diagnostic.goto_prev()
  end
  keymaps = {ga = _8_, gd = _9_, gi = _10_, gr = _11_, gtd = _12_, gh = _13_, gn = _14_, gp = _15_}
  local _local_16_ = require("me.config.keymaps")
  local load_keymaps_for_mode = _local_16_["load_keymaps_for_mode"]
  return load_keymaps_for_mode("n", keymaps, bufopts)
end
local function setup_lsp_signature(client, bufnr)
  local has_lsp_signature_3f, lsp_signature = pcall(require, "lsp_signature")
  if has_lsp_signature_3f then
    return lsp_signature.setup({}, bufnr)
  else
    return nil
  end
end
local function setup_navic(client, bufnr)
  local has_navic_3f, navic = pcall(require, "nvim-navic")
  if (has_navic_3f and client.server_capabilities.documentSymbolProvider) then
    return navic.attach(client, bufnr)
  else
    return nil
  end
end
local function setup_fidget(client, bufnr)
  local has_fidget_3f, fidget = pcall(require, "fidget")
  if has_fidget_3f then
    return fidget.setup({})
  else
    return nil
  end
end
local function on_attach(client, bufnr)
  set_keymaps(bufnr)
  show_diagnostic_on_focus(client, bufnr)
  format_on_save(client, bufnr)
  document_highlight(client, bufnr)
  setup_lsp_signature(client, bufnr)
  setup_navic(client, bufnr)
  setup_fidget()
  return nil
end
local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_3f, cmp = pcall(require, "cmp_nvim_lsp")
  if has_cmp_3f then
    capabilities = cmp.default_capabilities(capabilities)
  else
  end
  return capabilities
end
local signs = {Error = "\239\153\153 ", Warn = "\239\148\169 ", Hint = "\239\160\181 ", Info = "\239\145\137 "}
local function setup_signs()
  for type, icon in pairs(signs) do
    local hl = ("DiagnosticSign" .. type)
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
  end
  return nil
end
local function config(opts)
  local defualt_opts = {on_attach = on_attach, capabilities = make_capabilities()}
  return vim.tbl_deep_extend("force", defualt_opts, (opts or {}))
end
return {signs = signs, setup_signs = setup_signs, get_servers = get_servers, on_attach = on_attach, config = config, make_capabilities = make_capabilities}