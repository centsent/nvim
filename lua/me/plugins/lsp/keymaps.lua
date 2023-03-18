-- :fennel:1679108791
local M = {}
local function _1_()
  return vim.lsp.buf.code_action()
end
local function _2_()
  return vim.lsp.buf.definition()
end
local function _3_()
  return vim.lsp.buf.implementation()
end
local function _4_()
  return vim.lsp.buf.rename()
end
local function _5_()
  return vim.lsp.buf.type_definition()
end
local function _6_()
  return vim.lsp.buf.hover()
end
local function _7_()
  return vim.lsp.buf.signature_help()
end
local function _8_()
  return vim.diagnostic.goto_next()
end
local function _9_()
  return vim.diagnostic.goto_prev()
end
local function _10_()
  return (require("me.plugins.lsp.format")).toggle()
end
M.keys = {{desc = "Code Action", mode = {"n", "v"}, has = "codeAction", "ga", _1_}, {desc = "Go to definition", "gd", _2_}, {desc = "Go to implementation", "gi", _3_}, {desc = "Rename", has = "rename", "gr", _4_}, {desc = "Go to Type Definition", "gD", _5_}, {desc = "Hover", "gk", _6_}, {desc = "Signature Help", has = "signatureHelp", "gK", _7_}, {desc = "Next diagnostic", "gn", _8_}, {desc = "Prev diagnostic", "gp", _9_}, {desc = "Toggle autoformat", "gF", _10_}}
local function parse_lazy_keymaps(keys)
  local LazyKeysHandler = require("lazy.core.handler.keys")
  local lazy_keymaps = {}
  for _, value in ipairs(keys) do
    local keymap = LazyKeysHandler.parse(value)
    local rhs = keymap[2]
    local no_rhs = ((rhs == vim.NIL) or (rhs == false))
    if no_rhs then
      lazy_keymaps[keymap.id] = nil
    else
      lazy_keymaps[keymap.id] = keymap
    end
  end
  return lazy_keymaps
end
local function set_lazy_key(client, buffer, lazy_key)
  local LazyKeysHandler = require("lazy.core.handler.keys")
  local no_provider = (not lazy_key.has or client.server_capabilities[(lazy_key.has .. "Provider")])
  if no_provider then
    local opts = LazyKeysHandler.opts(lazy_key)
    opts.has = nil
    opts.silent = true
    opts.buffer = buffer
    local mode = (lazy_key.mode or "n")
    local lhs = lazy_key[1]
    local rhs = lazy_key[2]
    return vim.keymap.set(mode, lhs, rhs, opts)
  else
    return nil
  end
end
local function set_keymaps(client, buffer, lazy_keymaps)
  for _, lazy_key in pairs(lazy_keymaps) do
    set_lazy_key(client, buffer, lazy_key)
  end
  return nil
end
M["on-attach"] = function(client, buffer)
  local lazy_keymaps = parse_lazy_keymaps(M.keys)
  return set_keymaps(client, buffer, lazy_keymaps)
end
return M