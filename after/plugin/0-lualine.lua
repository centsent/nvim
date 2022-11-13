-- :fennel:1668273097
local has_lualine_3f, lualine = pcall(require, "lualine")
if has_lualine_3f then
  local lsp_signs = (require("me.lsp")).signs
  local bold = "bold"
  local colors = {bg = "#292e42", fg = "#bbc2cf", lightblue = "#7aa2f7", lime = "#9ece6a", yellow = "#ECBE7B", cyan = "#008080", green = "#98be65", orange = "#e0af68", magenta = "#c678dd", blue = "#51afef", red = "#ec5f67", lavender = "#bb9af7", rose = "#f7768e", white = "#ffffff"}
  local mode_colors = {n = colors.lightblue, v = colors.lavender, x = colors.rose, i = colors.lime, o = colors.cyan, R = colors.rose}
  local icons = {branch = "\238\156\165", added = "\239\129\149 ", modified = "\239\145\153 ", removed = "\239\129\150 "}
  local components
  local function _1_()
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
  local function _3_()
    return (require("utils")).get_formatter_name()
  end
  local function _4_()
    return (require("utils")).get_linter_name()
  end
  local function _5_()
    return "%="
  end
  local function _6_()
    local fg_color = (mode_colors[vim.fn.mode()] or colors.rose)
    return {fg = fg_color, bg = colors.bg}
  end
  local function _7_()
    return string.format("%s", os.date("%H:%M:%S"))
  end
  components = {fileformat = {color = {bg = colors.bg, fg = colors.green, gui = bold}, "fileformat"}, encoding = {color = {bg = colors.bg, fg = colors.green, gui = bold}, fmt = string.upper, "encoding"}, filename = {color = {fg = colors.blue, gui = bold}, "filename"}, filetype = {icon_only = true, "filetype"}, filesize = {color = {fg = colors.white}, "filesize"}, progress = {color = {bg = colors.bg, fg = colors.fg, gui = bold}, "progress"}, location = {color = {bg = colors.bg, fg = colors.fg, gui = bold}, "location"}, branch = {icon = icons.branch, color = {bg = colors.bg, fg = colors.magenta, gui = bold}, "branch"}, diff = {symbols = {added = icons.added, modified = icons.modified, removed = icons.removed}, diff_color = {added = {fg = colors.green}, modified = {fg = colors.orange}, removed = {fg = colors.red}}, color = {bg = colors.bg}, "diff"}, diagnostics = {sources = {"nvim_diagnostic"}, symbols = {error = lsp_signs.Error, warn = lsp_signs.Warn, info = lsp_signs.Info}, diagnostics_color = {color_error = {fg = colors.red}, color_warn = {fg = colors.yellow}, color_info = {fg = colors.cyan}}, color = {bg = colors.bg}, "diagnostics"}, lsp = {color = {fg = colors.white, gui = bold}, _1_}, formatter = {color = {fg = colors.green}, _3_}, linter = {color = {fg = colors.cyan}, _4_}, gap = {_5_}, mode = {color = _6_, "mode"}, time = {color = {fg = colors.green, bg = colors.bg}, _7_}}
  local config = {options = {component_separators = "", section_separators = ""}, sections = {lualine_a = {components.mode}, lualine_b = {components.branch, components.diff, components.diagnostics}, lualine_c = {components.filetype, components.filename, components.filesize, components.gap, components.lsp, components.formatter, components.linter}, lualine_x = {components.progress}, lualine_y = {components.location}, lualine_z = {components.encoding, components.fileformat, components.time}}}
  local function setup(user_config)
    return lualine.setup(user_config)
  end
  return setup(config)
else
  return nil
end