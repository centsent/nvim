local has_formatter, formatter = pcall(require, "formatter")
if not has_formatter then
  return
end

local get_current_buf_name = function()
  return vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
end

local prettier_config = function()
  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      get_current_buf_name(),
      "--tab-width",
      2,
    },
    stdin = true,
  }
end

local lua_config = function()
  return {
    exe = "stylua",
    args = {
      "--indent-width",
      2,
      "--indent-type",
      "Spaces",
      "--line-endings",
      "Unix",
      "--quote-style",
      "AutoPreferDouble",
    },
  }
end

local vue_config = function()
  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      get_current_buf_name(),
      "--doule-quote",
      "--tab-width",
      2,
      "--parser",
      "vue",
    },
    stdin = true,
  }
end

local java_config = function()
  return {
    exe = "java",
    name = "google-java-format",
    args = {
      "-jar",
      os.getenv("HOME") .. "/.local/jars/google-java-format.jar",
      get_current_buf_name(),
    },
    stdin = true,
  }
end

local php_config = function()
  return {
    -- Install phpcbf via composer:
    -- $ composer global require squizlabs/php_codesniffer
    -- and make sure global vendor binaries directory is in $PATH
    exe = "phpcbf",
    args = {
      "--standard=PSR12",
      get_current_buf_name(),
    },
    stdin = true,
    ignore_exitcode = true,
  }
end

local formatter_config = {
  lua = { lua_config },
  vue = { vue_config },
  php = { php_config },
  java = { java_config },
  fish = { require("formatter.filetypes.fish").fishindent },
  ruby = { require("formatter.filetypes.ruby").rubocop },
}

local common_filetypes = {
  "css",
  "scss",
  "html",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "markdown",
  "markdown.mdx",
  "json",
  "yaml",
  "xml",
  "svg",
  "svelte",
}

for _, filetype in ipairs(common_filetypes) do
  formatter_config[filetype] = { prettier_config }
end

formatter.setup({
  filetype = formatter_config,
})

-- Format on save
local group = vim.api.nvim_create_augroup("FormatAutogroup", {})
vim.api.nvim_create_autocmd("BufWritePost", { group = group, command = "FormatWrite" })
