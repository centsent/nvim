-- :fennel:1679748999
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
local function fennel_config()
  return {exe = "fnlfmt", stdin = true, args = {get_current_buf_name()}}
end
local common_filetypes = {"css", "scss", "graphql", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "markdown", "markdown.mdx", "json", "yaml", "xml", "svg", "svelte"}
local function get_formatters()
  local formatters = {lua = {lua_config}, vue = {vue_config}, php = {php_config}, java = {java_config}, fennel = {fennel_config}, fish = {(require("formatter.filetypes.fish")).fishindent}, python = {(require("formatter.filetypes.python")).black}, ruby = {(require("formatter.filetypes.ruby")).rubocop}, rust = {(require("formatter.filetypes.rust")).rustfmt}}
  for key_3_auto, val_4_auto in pairs(common_filetypes) do
    local function _1_(_, filetype)
      formatters[filetype] = prettier_config
      return nil
    end
    _1_(key_3_auto, val_4_auto)
  end
  return formatters
end
local function config(_, opts)
  opts.filetype = get_formatters()
  local formatter = require("formatter")
  return formatter.setup(opts)
end
return {opts = {}, config = config, event = {"BufReadPost", "BufNewFile", "BufWritePost"}, "mhartington/formatter.nvim"}