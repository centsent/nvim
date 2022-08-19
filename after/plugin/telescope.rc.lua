local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  return
end

local builtin = require("telescope.builtin")
local with = function(fn)
  return function()
    fn()
  end
end

telescope.setup({
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
    file_ignore_patterns = { "node_modules", ".git" },
  },
})

local function find_project_files()
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

-- Mappings
local set_keymap = vim.keymap.set

set_keymap("n", "ff", with(find_project_files))
set_keymap("n", "fb", with(builtin.buffers))
set_keymap("n", "fg", with(builtin.live_grep))
set_keymap("n", "fm", with(builtin.keymaps))
set_keymap("n", "fp", with(telescope.extensions.project.project))
set_keymap("n", "fd", with(builtin.lsp_document_symbols))
set_keymap("n", "fr", with(builtin.lsp_references))
