-- :fennel:1679586224
local function config(_, opts)
  local telescope = require("telescope")
  local _local_1_ = require("telescope.themes")
  local get_cursor = _local_1_["get_cursor"]
  opts.extensions["ui-select"] = get_cursor({})
  telescope.setup(opts)
  telescope.load_extension("ui-select")
  return telescope.load_extension("notify")
end
local dependencies = {"nvim-telescope/telescope-ui-select.nvim"}
local function telescope_builtin(picker)
  local function _2_()
    return (require("telescope.builtin"))[picker]()
  end
  return _2_
end
local function make_fd_command()
  return {"fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--follow"}
end
local function get_root_dir(client)
  if client then
    return client.config.root_dir
  else
    return nil
  end
end
local function find_project_files()
  local builtin = require("telescope.builtin")
  local client = vim.lsp.get_client_by_id(1)
  local root_dir = get_root_dir(client)
  local cwd = vim.fn.getcwd()
  local find_file_opts = {cwd = cwd}
  if root_dir then
    find_file_opts.cwd = root_dir
  else
  end
  if (vim.fn.executable("fd") == 1) then
    find_file_opts.find_command = make_fd_command()
  else
  end
  return builtin.find_files(find_file_opts)
end
local function get_telescope_keymaps()
  local function _6_()
    return find_project_files()
  end
  return {{desc = "Find files in current project folder", "ff", _6_}, {desc = "Telescope buffers", "fb", telescope_builtin("buffers")}, {desc = "Telescope live grep", "fg", telescope_builtin("live_grep")}, {desc = "Telescope keymaps", "fm", telescope_builtin("keymaps")}, {desc = "Telescope list lsp document symbols", "fd", telescope_builtin("lsp_document_symbols")}, {desc = "Telescope list lsp references", "fr", telescope_builtin("lsp_references")}, {desc = "Viewing Notify history", "fn", ":Telescope notify<cr>"}}
end
local opts = {defaults = {file_ignore_patterns = {"node_modules", ".git/", "vendor/*", ".mypy_cache/.*", "__pycache__/*", "venv/", "*.png", "*.jpg"}, vimgrep_arguments = {"rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden", "--follow", "--trim"}}, pickers = {live_grep = {theme = "dropdown"}}, extensions = {}}
return {dependencies = dependencies, opts = opts, config = config, keys = get_telescope_keymaps, "nvim-telescope/telescope.nvim"}