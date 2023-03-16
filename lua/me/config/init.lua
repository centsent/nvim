-- :fennel:1678804935
local M = {}
local function set_colorscheme()
  local has_tyokonight_3f, tokyonight = pcall(require, "tokyonight")
  return tokyonight.load()
end
local function load_configs()
  local util = require("me.util")
  local config_prefix = "me.config."
  local mods = {"options", "keymaps"}
  for _, mod in ipairs(mods) do
    util.load((config_prefix .. mod))
  end
  return nil
end
M.setup = function(opts)
  local util = require("me.util")
  local function _1_(params)
    set_colorscheme()
    return load_configs()
  end
  return util["on-very-lazy"](_1_)
end
return M