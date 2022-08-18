local ok, formatter = pcall(require, "formatter")
if not ok then
  return
end

local prettier_config = function()
  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
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
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
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
    args = {
      "-jar",
      os.getenv("HOME") .. "/.local/jars/google-java-format.jar",
      vim.api.nvim_buf_get_name(0),
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
      vim.api.nvim_buf_get_name(0),
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

-- Format on save
formatter.setup({
  filetype = formatter_config,
})

local group = vim.api.nvim_create_augroup("FormatAutogroup", {})
vim.api.nvim_create_autocmd("BufWritePost", { group = group, command = "FormatWrite" })
