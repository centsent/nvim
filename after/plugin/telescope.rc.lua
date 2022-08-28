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
    file_ignore_patterns = { "node_modules", ".git", "vendor" },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
}

telescope.setup(settings)

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

require("keymaps").load_keymaps(telescope_keymaps)

telescope.load_extension("ui-select")
