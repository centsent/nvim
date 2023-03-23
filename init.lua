-- Bootstraps a plugin by cloning its repository from the given URL,
-- and adding it to the runtime path.
-- If the plugin is already installed, just updates the runtime path.
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

local function init_plugin(url, name)
  bootstrap(url)
  return require(name)
end

local function init_tangerine()
  local tangerine = init_plugin("https://github.com/udayvir-singh/tangerine.nvim", "tangerine")
  tangerine.setup({
    rtpdirs = { "plugin", "after", "ftplugin", "ftdetect" },
    compiler = { hooks = { "oninit", "onsave" }, verbose = false },
  })
end

local function init_lazy()
  local lazy = init_plugin("https://github.com/folke/lazy.nvim", "lazy")
  vim.g.mapleader = ","

  lazy.setup({
    spec = {
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
