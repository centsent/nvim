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
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
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

local telescope_keymaps = {
  -- Normal mode
  normal_mode = {
    ["ff"] = with(find_project_files),
    ["fb"] = with(builtin.buffers),
    ["fg"] = with(builtin.live_grep),
    ["fm"] = with(builtin.keymaps),
    ["fd"] = with(builtin.lsp_document_symbols),
    ["fr"] = with(builtin.lsp_references),
  },
}

require("keymaps").load_keymaps(telescope_keymaps)

telescope.load_extension("ui-select")
