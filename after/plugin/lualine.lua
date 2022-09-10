local has_lualine, lualine = pcall(require, "lualine")
if not has_lualine then
  return
end

local signs = require("me.lsp").signs
local bold = "bold"
local colors = {
  bg = "#292e42",
  fg = "#bbc2cf",
  lightblue = "#7aa2f7",
  lime = "#9ece6a",
  yellow = "#ECBE7B",
  cyan = "#008080",
  green = "#98be65",
  orange = "#e0af68",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  lavender = "#bb9af7",
  rose = "#f7768e",
  white = "#ffffff",
}
local mode_colors = {
  ["n"] = colors.lightblue,
  ["v"] = colors.lavender,
  ["x"] = colors.rose,
  ["i"] = colors.lime,
  ["o"] = colors.cyan,
  ["R"] = colors.rose,
}
local icons = {
  branch = "",
  added = " ",
  modified = " ",
  removed = " ",
}

local components = {
  fileformat = {
    "fileformat",
    color = { bg = colors.bg, fg = colors.green, gui = bold },
  },
  encoding = {
    "encoding",
    color = { bg = colors.bg, fg = colors.green, gui = bold },
    fmt = string.upper,
  },
  filename = {
    "filename",
    color = { fg = colors.blue, gui = bold },
  },
  filetype = {
    "filetype",
    icon_only = true,
  },
  filesize = {
    "filesize",
    color = { fg = colors.white },
  },
  progress = {
    "progress",
    color = { bg = colors.bg, fg = colors.fg, gui = bold },
  },
  location = {
    "location",
    color = { bg = colors.bg, fg = colors.fg, gui = bold },
  },
  branch = {
    "branch",
    icon = icons.branch,
    color = { bg = colors.bg, fg = colors.magenta, gui = bold },
  },
  diff = {
    "diff",
    symbols = {
      added = icons.added,
      modified = icons.modified,
      removed = icons.removed,
    },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.orange },
      removed = { fg = colors.red },
    },
    color = { bg = colors.bg },
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = signs.Error, warn = signs.Warn, info = signs.Error },
    diagnostics_color = {
      color_error = { fg = colors.red },
      color_warn = { fg = colors.yellow },
      color_info = { fg = colors.cyan },
    },
    color = { bg = colors.bg },
  },
  lsp = {
    function()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.buf_get_clients(bufnr)

      if next(clients) == nil then
        return "No Active LSP"
      end

      local names = {}
      for _, client in pairs(clients) do
        names[#names + 1] = client.name
      end

      return table.concat(names, ", ")
    end,
    color = { fg = colors.white, gui = bold },
  },
  formatter = {
    function()
      return require("utils").get_formatter_name()
    end,
    color = { fg = colors.green },
  },
  linter = {
    function()
      return require("utils").get_linter_name()
    end,
    color = { fg = colors.cyan },
  },
  gap = {
    function()
      return "%="
    end,
  },
  mode = {
    "mode",
    color = function()
      local fg_color = mode_colors[vim.fn.mode()] or colors.rose
      return { fg = fg_color, bg = colors.bg }
    end,
  },
}

local config = {
  options = {
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = { components.mode },
    lualine_b = { components.branch, components.diff, components.diagnostics },
    lualine_c = {
      components.filetype,
      components.filename,
      components.filesize,
      components.gap,
      components.lsp,
      components.formatter,
      components.linter,
    },
    lualine_x = { components.progress },
    lualine_y = { components.location },
    lualine_z = { components.encoding, components.fileformat },
  },
}

lualine.setup(config)
