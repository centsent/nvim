local ok, formatter = pcall(require, "formatter")
if not ok then
  return
end

local prettier_config = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)) },
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

local function vue_config()
  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      "--single-quote",
      "--parser",
      "vue",
    },
    stdin = true,
  }
end

local formatter_config = {
  lua = { lua_config },
  vue = { vue_config },
  ["*"] = {
    function()
      return {
        -- remove trailing whitespace
        exe = "sed",
        args = { "-i", "'s/[ \t]*$//'" },
        stdin = false,
      }
    end,
  },
}

local common_filetypes = {
  "css",
  "scss",
  "html",
  "java",
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

local group = vim.api.nvim_create_augroup("FormatAutogroup", {})
vim.api.nvim_create_autocmd("BufWritePost", { group = group, command = "FormatWrite" })
