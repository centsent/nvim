-- :fennel:1678978272
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
  return vim.diagnostic.goto_next()
end
local function _8_()
  return vim.diagnostic.goto_prev()
end
M.keys = {{desc = "Code Action", mode = {"n", "v"}, has = "codeAction", "ga", _1_}, {desc = "Go to definition", "gd", _2_}, {desc = "Go to implementation", "gi", _3_}, {desc = "Rename", has = "rename", "gr", _4_}, {desc = "Go to Type Definition", "gD", _5_}, {desc = "Hover", "gh", _6_}, {desc = "Next diagnostic", "gn", _7_}, {desc = "Prev diagnostic", "gp", _8_}}
local function parse_keymaps(keys)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}
  for _, value in ipairs(keys) do
    local keymap = Keys.parse(value)
    local rhs = keymap[2]
    local no_rhs = ((rhs == vim.NIL) or (rhs == false))
    if no_rhs then
      keymaps[keymap.id] = nil
    else
      keymaps[keymap.id] = keymap
    end
  end
  return keymaps
end
local function set_keymaps(client, buffer, keymaps)
  local LazyKeys = require("lazy.core.handler.keys")
  for _, keys in pairs(keymaps) do
    local no_provider = (not keys.has or client.server_capabilities[(keys.has .. "Provider")])
    if no_provider then
      local opts = LazyKeys.opts(keys)
      opts.has = nil
      opts.silent = true
      opts.buffer = buffer
      local mode = (keys.mode or "n")
      local lhs = keys[1]
      local rhs = keys[2]
      vim.keymap.set(mode, lhs, rhs, opts)
    else
    end
  end
  return nil
end
M["on-attach"] = function(client, buffer)
  local keymaps = parse_keymaps(M.keys)
  return set_keymaps(client, buffer, keymaps)
end
return M