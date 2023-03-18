-- :fennel:1679111384
local lsp_signs = (require("me.lsp")).signs
local bold = "bold"
local colors = {bg = "#292e42", fg = "#bbc2cf", lightblue = "#7aa2f7", lime = "#9ece6a", yellow = "#ECBE7B", cyan = "#008080", green = "#98be65", orange = "#e0af68", magenta = "#c678dd", blue = "#51afef", red = "#ec5f67", lavender = "#bb9af7", rose = "#f7768e", white = "#ffffff"}
local mode_colors = {n = colors.lightblue, v = colors.lavender, x = colors.rose, i = colors.lime, o = colors.cyan, R = colors.rose}
local icons = {branch = "\238\156\165", added = "\239\129\149 ", modified = "\239\145\153 ", removed = "\239\129\150 "}
local fileformat = {color = {bg = colors.bg, fg = colors.green, gui = bold}, "fileformat"}
local encoding = {color = {bg = colors.bg, fg = colors.green, gui = bold}, fmt = string.upper, "encoding"}
local filename = {color = {fg = colors.blue, gui = bold}, "filename"}
local filetype = {icon_only = true, "filetype"}
local filesize = {color = {fg = colors.white}, "filesize"}
local progress = {color = {bg = colors.bg, fg = colors.fg, gui = bold}, "progress"}
local location = {color = {bg = colors.bg, fg = colors.fg, gui = bold}, "location"}
local branch = {icon = icons.branch, color = {bg = colors.bg, fg = colors.magenta, gui = bold}, "branch"}
local diff_symbols = {added = icons.added, modified = icons.modified, removed = icons.removed}
local diff_color = {added = {fg = colors.green}, modified = {fg = colors.orange}, removed = {fg = colors.red}}
local diff = {symbols = diff_symbols, diff_color = diff_color, color = {bg = colors.bg}, "diff"}
local diagnostics_symbols = {error = lsp_signs.Error, warn = lsp_signs.Warn, info = lsp_signs.Info}
local diagnostics_color = {color_error = {fg = colors.red}, color_warn = {fg = colors.yellow}, color_info = {fg = colors.cyan}}
local diagnostics = {sources = {"nvim_diagnostic"}, symbols = diagnostics_symbols, diagnostics_color = diagnostics_color, color = {bg = colors.bg}, "diagnostics"}
local function set_lsp()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_active_clients({bufnr = bufnr})
  if (nil == next(clients)) then
    return "No Active LSP"
  else
    local names = {}
    for _, client in pairs(clients) do
      names[(#names + 1)] = client.name
    end
    return table.concat(names, " ")
  end
end
local lsp = {color = {fg = colors.white, gui = bold}, set_lsp}
local formatter
local function _2_()
  local util = require("me.util")
  return util.has("formatter.nvim")
end
local function _3_()
  return (require("me.util"))["get-formatter-name"]()
end
formatter = {color = {fg = colors.green}, cond = _2_, _3_}
local linter
local function _4_()
  local util = require("me.util")
  return util.has("nvim-lint")
end
local function _5_()
  return (require("me.util"))["get-linter-name"]()
end
linter = {color = {fg = colors.cyan}, cond = _4_, _5_}
local gap
local function _6_()
  return "%="
end
gap = {_6_}
local function set_mode_color()
  local fg_color = (mode_colors[vim.fn.mode()] or colors.rose)
  return {fg = fg_color, bg = colors.bg}
end
local mode = {color = set_mode_color, "mode"}
local function get_current_time()
  return string.format("%s", os.date("%H:%M:%S"))
end
local time = {color = {fg = colors.green, bg = colors.bg}, get_current_time}
local components = {encoding = encoding, fileformat = fileformat, filename = filename, filetype = filetype, filesize = filesize, progress = progress, location = location, branch = branch, diff = diff, diagnostics = diagnostics, lsp = lsp, formatter = formatter, linter = linter, gap = gap, mode = mode, time = time}
local sections = {lualine_a = {components.mode}, lualine_b = {components.branch, components.diff, components.diagnostics}, lualine_c = {components.filetype, components.filename, components.filesize, components.gap, components.lsp, components.formatter, components.linter}, lualine_x = {components.progress}, lualine_y = {components.location}, lualine_z = {components.encoding, components.fileformat, components.time}}
local opts = {options = {component_separators = "", section_separators = ""}, sections = sections}
return {opts = opts, event = "VeryLazy", "nvim-lualine/lualine.nvim"}