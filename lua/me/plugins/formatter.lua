-- :fennel:1678538069
local function config()
  local formatter = require("formatter")
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
  local _local_1_ = require("formatter.filetypes.fish")
  local fishindent = _local_1_["fishindent"]
  local _local_2_ = require("formatter.filetypes.ruby")
  local rubocop = _local_2_["rubocop"]
  local _local_3_ = require("formatter.filetypes.rust")
  local rustfmt = _local_3_["rustfmt"]
  local formatter_config = {lua = {lua_config}, vue = {vue_config}, php = {php_config}, java = {java_config}, fish = {fishindent}, ruby = {rubocop}, rust = {rustfmt}, fennel = {fennel_config}}
  local function setup_common_filetypes()
    local common_filetypes = {"css", "scss", "graphql", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "markdown", "markdown.mdx", "json", "yaml", "xml", "svg", "svelte"}
    for _, filetype in ipairs(common_filetypes) do
      formatter_config[filetype] = {prettier_config}
    end
    return nil
  end
  local function format_on_save()
    local augroup = vim.api.nvim_create_augroup("FormatAutogroup", {clear = true})
    return vim.api.nvim_create_autocmd("BufWritePost", {group = augroup, command = "FormatWrite"})
  end
  setup_common_filetypes()
  formatter.setup({filetype = formatter_config})
  return format_on_save()
end
return {config = config, event = "BufWritePost", "mhartington/formatter.nvim"}