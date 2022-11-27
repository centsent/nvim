local pack = "packer"

local function bootstrap(url)
  local name = url:gsub(".*/", "")
  local path = vim.fn.stdpath("data") .. "/site/pack/" .. pack .. "/start/" .. name

  if vim.fn.isdirectory(path) == 0 then
    print(name .. ": installing in data dir...")

    vim.fn.system({ "git", "clone", "--depth", "1", url, path })

    vim.cmd("redraw")
    print(name .. ": finished installing")
  end
end

local function setup_impatient()
  bootstrap("https://github.com/lewis6991/impatient.nvim")
  require("impatient").enable_profile()
end

local function setup_tangerine()
  bootstrap("https://github.com/udayvir-singh/tangerine.nvim")
  local tangerine_settings = {

    rtpdirs = {
      "plugin",
      "after",
      "ftplugin",
      "ftdetect",
    },
    compiler = {
      verbose = false,
      hooks = {
        "oninit",
        "onsave",
      },
    },
  }

  require("tangerine").setup(tangerine_settings)
end

setup_impatient()
setup_tangerine()
