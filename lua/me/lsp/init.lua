local M = {}

local o = function(option, value)
  vim.api.nvim_set_option(option, value)
end

local with = require("utils").with

M.get_servers = function()
  return {
    "bashls",
    "clangd",
    "csharp_ls",
    "cssls",
    "cmake",
    "gopls",
    "html",
    "jsonls",
    "julials",
    "marksman",
    "phpactor",
    "pyright",
    "rust_analyzer",
    "sumneko_lua",
    "tsserver",
    "vimls",
    "volar",
    "yamlls",
  }
end

M.on_attach = function(client, bufnr)
  local buf_set_keymap = function(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local buf_set_option = function(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  local format_on_save = function()
    local has_fmtconfig, fmtconfig = pcall(require, "formatter.config")
    if not has_fmtconfig then
      vim.lsp.buf.formatting({})
      return
    end

    local formatters = fmtconfig.values.filetype
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    if not formatters[ft] then
      vim.lsp.buf.formatting({})
    end
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  -- Mappings.
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

  -- Set updatetime for CursorHold
  -- 300ms of no cursor movement to trigger CursorHold
  o("updatetime", 300)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = false })
    end,
  })

  -- have a fixed column for the diagnostics to appear in
  -- this removes the jitter when warnings/errors flow in
  o("signcolumn", "yes")

  -- Format on save if the lsp client supports formatting
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = bufnr,
      callback = with(format_on_save),
    })
  end
end

M.make_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- Set up completion using nvim_cmp with LSP source
  local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
  if has_cmp then
    capabilities = cmp.update_capabilities(capabilities)
  end

  return capabilities
end

M.get_default_config = function()
  return {
    capabilities = M.make_capabilities(),
    on_attach = M.on_attach,
    flags = { debounce_text_change = 150 },
  }
end

M.extend_config = function(name, config)
  local has_lspconfig, lspconfig = pcall(require, "lspconfig")
  if not has_lspconfig then
    return
  end

  lspconfig[name].setup(vim.tbl_deep_extend("force", M.get_default_config(), config))
end

return M
