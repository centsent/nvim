local utils = require("utils")
local safe_require = utils.safe_require
local has_telescope, telescope = safe_require("telescope")
if not has_telescope then
  return
end

local builtin = require("telescope.builtin")
local logger = require("logger")
local with = utils.with

local find_files_opts = {
  hidden = true,
  follow = true,
}

local settings = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--follow",
    },
    file_ignore_patterns = {
      "node_modules",
      ".git/*",
      "vendor/*",
      ".mypy_cache/.*",
      "__pycache__/*",
      "*.png",
      "*.jpg",
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor({}),
    },
    ["file_browser"] = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
    },
  },
}

local setup = function(config)
  telescope.setup(config)
  telescope.load_extension("ui-select")
  telescope.load_extension("file_browser")
end

local find_files_command = function()
  return {
    "fd",
    "--type",
    "f",
    "--strip-cwd-prefix",
    "--color",
    "never",
  }
end

local find_project_files = function()
  local cwd = os.getenv("PWD")
  local client = vim.lsp.get_client_by_id(1)

  if client then
    cwd = client.config.root_dir
  end

  if utils.is_executable("fd") then
    find_files_opts.find_command = find_files_command()
  end

  find_files_opts.cwd = cwd
  builtin.find_files(find_files_opts)
end

local live_grep = function()
  if not utils.is_executable("rg") then
    logger.error("Please install ripgrep to use live grep")
    return
  end

  builtin.live_grep()
end

local telescope_keymaps = {
  -- Normal mode
  normal_mode = {
    ["ff"] = with(find_project_files),
    ["fb"] = with(builtin.buffers),
    ["fg"] = with(live_grep),
    ["fm"] = with(builtin.keymaps),
    ["fd"] = with(builtin.lsp_document_symbols),
    ["fr"] = with(builtin.lsp_references),
    ["fn"] = ":Telescope notify<cr>",
  },
}

local set_keymaps = function(keymaps)
  require("keymaps").load_keymaps(keymaps)
end

local setup_commands = function()
  -- disable `netrw` before creating `Lex` command
  vim.g.loaded_netrw = 1

  -- I remapped `<leader>f` to `Lex`
  -- so create a `Lex` command to replace netrw with file-browser
  vim.api.nvim_create_user_command("Lex", with(telescope.extensions.file_browser.file_browser), {})
end

setup(settings)
set_keymaps(telescope_keymaps)
setup_commands()
