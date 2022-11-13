-- :fennel:1668306286
local has_formatter_3f, formatter = pcall(require, "formatter")
if has_formatter_3f then
  local function get_current_buf_name()
    return vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
  end
  local function prettier_config()
    return {exe = "prettier", args = {"--stdin-filepath", get_current_buf_name(), "--tab-width", 2}, stdin = true}
  end
  local function lua_config()
    return {exe = "stylua", args = {"--indent-width", 2, "--indent-type", "Spaces", "--line-endings", "Unix", "--quote-style", "AutoPreferDouble"}}
  end
  local function vue_config()
    return {exe = "prettier", stdin = true, args = {"--stdin-filepath", get_current_buf_name(), "--doule-quote", "--tab-width", 2, "--parser", "vue"}}
  end
  local function java_config()
    return {exe = "java", name = "google-java-format", stdin = true, args = {"-jar", (os.getenv("HOME") .. "/.local/jars/google-java-format.jar"), get_current_buf_name()}}
  end
  local function php_config()
    return {exe = "phpcbf", args = {"--standard=PSR12", get_current_buf_name()}, stdin = true, ignore_exitcode = true}
  end
  local formatter_config = {lua = {lua_config}, vue = {vue_config}, php = {php_config}, java = {java_config}, fish = {(require("formatter.filetypes.fish")).fishindent}, ruby = {(require("formatter.filetypes.ruby")).rubocop}}
  local common_filetypes = {"css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "markdown", "markdown.mdx", "json", "yaml", "xml", "svg", "svelte"}
  for _, filetype in ipairs(common_filetypes) do
    formatter_config[filetype] = {prettier_config}
  end
  formatter.setup({filetype = formatter_config})
  local augroup = vim.api.nvim_create_augroup("FormatAutogroup", {clear = true})
  return vim.api.nvim_create_autocmd("BufWritePost", {group = augroup, command = "FormatWrite"})
else
  return nil
end