local function bootstrap(url)
  local name = url:gsub(".*/", "")
  local path = vim.fn.stdpath("data") .. "/lazy/" .. name
  vim.opt.rtp:prepend(path)

  if not vim.loop.fs_stat(path) then
    print(name .. ": installing in data dir...")
    vim.fn.system({ "git", "clone", url, path })
    vim.cmd("redraw")
    print(name .. ": finished installing")
  end
end

local function init_tangerine()
  bootstrap("https://github.com/udayvir-singh/tangerine.nvim")
  local has_tangerine, tangerine = pcall(require, "tangerine")
  if not has_tangerine then
    return
  end
  tangerine.setup({
    -- target = vim.fn.stdpath([[data]]) .. "/tangerine",
    rtpdirs = { "plugin", "after", "ftplugin", "ftdetect" },
    compiler = { hooks = { "oninit", "onsave" }, verbose = false },
  })
end

local function init_lazy()
  bootstrap("https://github.com/folke/lazy.nvim")
  vim.g.mapleader = ","

  local has_lazy, lazy = pcall(require, "lazy")
  if not has_lazy then
    return
  end

  lazy.setup({
    spec = {
      { import = "me.plugins.extras.lsp" },
      { import = "me.plugins" },
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "netrwPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
  require("me.config").setup({})
end

init_tangerine()
init_lazy()
