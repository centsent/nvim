local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  return
end

local builtin = require("telescope.builtin")
local logger = require("logger")
local utils = require("utils")
local with = utils.with

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
    file_ignore_patterns = { "node_modules", ".git/", "vendor/" },
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

local find_project_files = function()
  local cwd = os.getenv("PWD")
  local client = vim.lsp.get_client_by_id(1)

  if client then
    cwd = client.config.root_dir
  end

  builtin.find_files({
    cwd = cwd,
    hidden = true,
  })
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
  },
}

local set_keymaps = function(keymaps)
  require("keymaps").load_keymaps(keymaps)
end

local set_lex_command = function()
  -- create `Lex` command if netrw was disabled
  if vim.g.loaded_netrw ~= 1 then
    return
  end

  -- I remapped `<leader>f` to `Lex`
  -- so create a `Lex` command to replace netrw with file-browser
  vim.api.nvim_create_user_command("Lex", with(telescope.extensions.file_browser.file_browser), {})
end

setup(settings)
set_keymaps(telescope_keymaps)
set_lex_command()
