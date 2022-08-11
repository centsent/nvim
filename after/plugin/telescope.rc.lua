local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end
local builtin = require("telescope.builtin")

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
local keymap = vim.keymap

keymap.set("n", "ff", find_project_files)
keymap.set("n", "fb", builtin.buffers)
keymap.set("n", "fg", builtin.live_grep)
keymap.set("n", "fm", builtin.keymaps)
keymap.set("n", "fr", builtin.lsp_references)
keymap.set("n", "fd", builtin.lsp_document_symbols)
keymap.set("n", "fp", telescope.extensions.project.project)
