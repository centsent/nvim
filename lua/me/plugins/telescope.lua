-- :fennel:1679056885
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
    local builtin = require("telescope.builtin")
    return builtin[name]()
  end
  return _1_
end
local function find_files_command()
  return {"fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--follow"}
end
local function find_project_files()
  local find_files_opts = {hidden = true, follow = true}
  local builtin = require("telescope.builtin")
  local cwd = os.getenv("PWD")
  local client = vim.lsp.get_client_by_id(1)
  if client then
    cwd = client.config.root_dir
  else
  end
  if (vim.fn.executable("fd") == 1) then
    find_files_opts.find_command = find_files_command()
  else
  end
  find_files_opts.cwd = cwd
  return builtin.find_files(find_files_opts)
end
local function get_telescope_keymaps()
  local function _4_()
    return find_project_files()
  end
  return {{desc = "Find files in current project folder", "ff", _4_}, {desc = "Telescope buffers", "fb", telescope_builtin("buffers")}, {desc = "Telescope live grep", "fg", telescope_builtin("live_grep")}, {desc = "Telescope keymaps", "fm", telescope_builtin("keymaps")}, {desc = "Telescope list lsp document symbols", "fd", telescope_builtin("lsp_document_symbols")}, {desc = "Telescope list lsp references", "fr", telescope_builtin("lsp_references")}, {desc = "Viewing Notify history", "fn", ":Telescope notify<cr>"}}
end
return {config = config, dependencies = dependencies, keys = get_telescope_keymaps, "nvim-telescope/telescope.nvim"}