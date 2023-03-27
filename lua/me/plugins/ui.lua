-- :fennel:1679885050
local function init_notify()
  local util = require("me.util")
  if not util.has("noice.nvim") then
    local function _1_()
      vim.notify = require("notify")
      return nil
    end
    return util["on-very-lazy"](_1_)
  else
    return nil
  end
end
local function _3_()
  return (require("notify")).dismiss({slient = true, pending = true})
end
return {{opts = {timeout = 3000, max_width = 80, background_colour = "#121212"}, init = init_notify, keys = {{desc = "Delete all notifications", "<leader>n", _3_}}, "rcarriga/nvim-notify"}, {opts = {char = "\226\148\130", filetype_exclude = {"help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy"}, show_trailing_blankline_indent = false, show_current_context = false}, event = {"BufReadPost", "BufNewFile"}, "lukas-reineke/indent-blankline.nvim"}, {event = "VeryLazy", opts = {lsp = {override = {["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true}, signature = {enabled = false}}, presets = {command_palette = true, long_message_to_split = true}}, "folke/noice.nvim"}, {event = "VeryLazy", opts = {options = {mode = "tabs", indicator = {style = "underline"}, show_close_icon = false, show_buffer_close_icons = false}}, "akinsho/bufferline.nvim"}, {opts = {position = "right", use_diagnostic_signs = true}, keys = {{desc = "Open trouble list (Trouble.nvim)", "gt", ":TroubleToggle<cr>"}}, "folke/trouble.nvim"}, {lazy = true, "kyazdani42/nvim-web-devicons"}, {lazy = true, "MunifTanjim/nui.nvim"}, {event = {"BufNewFile", "BufReadPost"}, opts = {current_line_blame = true}, "lewis6991/gitsigns.nvim"}, {opts = {excluded_filetypes = {"prompt", "TelescopePrompt", "noice", "notify"}}, event = "BufReadPost", "petertriho/nvim-scrollbar"}}