local has_lualine, lualine = pcall(require, "lualine")
if not has_lualine then
  return
end

local signs = require("me.lsp").signs

local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  green = "#98be65",
  orange = "#FF8800",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  gui_bold = "bold",
  white = "#ffffff",
}

local components = {
  fileformat = {
    "fileformat",
    color = { fg = colors.green, gui = colors.gui_bold },
  },
  encoding = {
    "encoding",
    color = { fg = colors.green, gui = colors.gui_bold },
    fmt = string.upper,
  },
  filename = {
    "filename",
    color = { fg = colors.blue, gui = colors.gui_bold },
  },
  filetype = {
    "filetype",
    color = { fg = colors.white },
    fmt = string.upper,
  },
  filesize = {
    "filesize",
    color = { fg = colors.white },
  },
  progress = {
    "progress",
    color = { bg = colors.bg, fg = colors.fg, gui = colors.gui_bold },
  },
  location = {
    "location",
    color = { bg = colors.bg, fg = colors.fg, gui = colors.gui_bold },
  },
  branch = {
    "branch",
    color = { bg = colors.bg, fg = colors.magenta, gui = colors.gui_bold },
  },
  diff = {
    "diff",
    symbols = { added = "+", modified = "柳", removed = "-" },
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
      local msg = "No Active LSP"
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.buf_get_clients(bufnr)

      if next(clients) == nil then
        return msg
      end

      local names = {}
      for _, client in pairs(clients) do
        names[#names + 1] = client.name
      end

      return table.concat(names, ", ")
    end,
    color = { fg = colors.white, gui = colors.gui_bold },
  },
  gap = {
    function()
      return "%="
    end,
  },
}

local config = {
  options = {
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { components.branch, components.diff, components.diagnostics },
    lualine_c = {
      components.filename,
      components.filesize,
      components.gap,
      components.filetype,
      components.lsp,
    },
    lualine_x = { components.encoding, components.fileformat },
    lualine_y = { components.progress },
    lualine_z = { components.location },
  },
}

lualine.setup(config)
