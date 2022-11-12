-- :fennel:1668265419
local has_telescope_3f, telescope = pcall(require, "telescope")
if has_telescope_3f then
  local builtin = require("telescope.builtin")
  local function with(func)
    local function _1_()
      return func()
    end
    return _1_
  end
  local find_files_opts = {hidden = true, follow = true}
  local settings = {defaults = {vimgrep_arguments = {"rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden", "--follow"}, file_ignore_patterns = {"node_modules", ".git/*", "vendor/*", ".mypy_cache/.*", "__pycache__/*", "*.png", "*.jpg"}}, extensions = {["ui-select"] = (require("telescope.themes")).get_cursor({}), file_browser = {theme = "ivy", hijack_netrw = true}}}
  local function setup(config)
    telescope.setup(config)
    telescope.load_extension("ui-select")
    return telescope.load_extension("file_browser")
  end
  local function find_files_command()
    return {"fd", "--type", "f", "--strip-cwd-prefix", "--color", "never"}
  end
  local function find_project_files()
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
  local telescope_keymaps = {normal_mode = {ff = with(find_project_files), fb = with(builtin.buffers), fg = with(builtin.live_grep), fm = with(builtin.keymaps), fd = with(builtin.lsp_document_symbols), fr = with(builtin.lsp_references), fn = ":Telescope notify<cr>"}}
  local function set_keymaps(keymaps)
    return (require("keymaps")).load_keymaps(keymaps)
  end
  local function setup_commands()
    vim.g.loaded_netrw = 1
    return vim.api.nvim_create_user_command("Lex", with(telescope.extensions.file_browser.file_browser), {})
  end
  setup(settings)
  set_keymaps(telescope_keymaps)
  return setup_commands()
else
  return nil
end