-- :fennel:1679151402
local M = {}
M.icons = {diagnostics = {Error = "\239\153\153 ", Warn = "\239\148\169 ", Hint = "\239\160\181 ", Info = "\239\145\137 "}, git = {added = "\239\131\190 ", modified = "\239\133\139 ", removed = "\239\133\134 "}, kinds = {Array = "\238\170\138 ", Boolean = "\238\170\143 ", Class = "\238\173\155 ", Color = "\238\173\156 ", Constant = "\238\173\157 ", Constructor = "\238\170\140 ", Copilot = "\238\156\136 ", Enum = "\238\170\149 ", EnumMember = "\238\173\158 ", Event = "\238\170\134 ", Field = "\238\173\159 ", File = "\238\169\187 ", Folder = "\239\157\138 ", Function = "\238\170\140 ", Interface = "\238\173\161 ", Key = "\238\170\147 ", Keyword = "\238\173\162 ", Method = "\238\170\140 ", Module = "\238\172\169 ", Namespace = "\238\170\139 ", Null = "\239\179\160 ", Number = "\238\170\144 ", Object = "\238\170\139 ", Operator = "\238\173\164 ", Package = "\238\172\169 ", Property = "\238\173\165 ", Reference = "\238\172\182 ", Snippet = "\238\173\166 ", String = "\238\174\141 ", Struct = "\238\170\145 ", Text = "\238\170\147 ", TypeParameter = "\238\170\146 ", Unit = "\238\170\150 ", Value = "\238\170\147 ", Variable = "\238\170\136 "}}
local function set_colorscheme()
  local has_tyokonight_3f, tokyonight = pcall(require, "tokyonight")
  if has_tyokonight_3f then
    return tokyonight.load()
  else
    return nil
  end
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
M.setup = function()
  local util = require("me.util")
  local function _2_()
    set_colorscheme()
    return load_configs()
  end
  return util["on-very-lazy"](_2_)
end
return M