-- :fennel:1679149050
local function config()
  local telescope = require("telescope")
  local defaults = {}
  local pickers = {}
  local extensions = {}
  defaults.vimgrep_arguments = {"rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden", "--follow", "--trim"}
  defaults.file_ignore_patterns = {"node_modules", ".git/", "vendor/*", ".mypy_cache/.*", "__pycache__/*", "*.png", "venv/", "*.jpg"}
  pickers.live_grep = {theme = "dropdown"}
  extensions["ui-select"] = (require("telescope.themes")).get_cursor({})
  local settings = {pickers = pickers, defaults = defaults, extensions = extensions}
  telescope.setup(settings)
  telescope.load_extension("ui-select")
  return telescope.load_extension("notify")
end
local dependencies = {"nvim-telescope/telescope-ui-select.nvim"}
local function telescope_builtin(name)
  local function _1_()
    return (require("telescope.builtin"))[name]()
  end
  return _1_
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
local function get_find_files_opts(cwd)
  return {hidden = true, follow = true, cwd = cwd, find_command = make_fd_command()}
end
local function find_project_files()
  local builtin = require("telescope.builtin")
  local cwd = vim.fn.getcwd()
  local client = vim.lsp.get_client_by_id(1)
  local root_dir = get_root_dir(client)
  if root_dir then
    cwd = root_dir
  else
  end
  if (vim.fn.executable("fd") == 1) then
    local find_files_opts = get_find_files_opts(cwd)
    return builtin.find_files(find_files_opts)
  else
    return nil
  end
end
local function get_telescope_keymaps()
  local function _5_()
    return find_project_files()
  end
  return {{desc = "Find files in current project folder", "ff", _5_}, {desc = "Telescope buffers", "fb", telescope_builtin("buffers")}, {desc = "Telescope live grep", "fg", telescope_builtin("live_grep")}, {desc = "Telescope keymaps", "fm", telescope_builtin("keymaps")}, {desc = "Telescope list lsp document symbols", "fd", telescope_builtin("lsp_document_symbols")}, {desc = "Telescope list lsp references", "fr", telescope_builtin("lsp_references")}, {desc = "Viewing Notify history", "fn", ":Telescope notify<cr>"}}
end
return {config = config, dependencies = dependencies, keys = get_telescope_keymaps, "nvim-telescope/telescope.nvim"}