-- :fennel:1669386367
local has_jdtls, jdtls = pcall(require, "jdtls")
if has_jdtls then
  local jdtls_setup = require("jdtls.setup")
  local _local_1_ = require("me.lsp")
  local make_capabilities = _local_1_["make_capabilities"]
  local on_attach = _local_1_["on_attach"]
  local home = os.getenv("HOME")
  local data_path = vim.fn.stdpath("data")
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = ((home .. "/.cache/jdtls-workspace/") .. project_name)
  local jdtls_install_dir = (data_path .. "/mason/packages/jdtls")
  local jdtls_jar = vim.fn.glob((jdtls_install_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar"))
  local root_dir = jdtls_setup.find_root({".git", "mvnw", "gradlew"})
  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  local cmd = {"java", "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-Dosgi.bundles.defaultStartLevel=4", "-Declipse.product=org.eclipse.jdt.ls.core.product", "-Dlog.protocol=true", "-Dlog.level=ALL", "-Xms1g", "--add-modules=ALL-SYSTEM", "--add-opens", "java.base/java.util=ALL-UNNAMED", "--add-opens", "java.base/java.lang=ALL-UNNAMED", "-jar", jdtls_jar, "-configuration", (jdtls_install_dir .. "/config_linux"), "-data", workspace_dir}
  local favoriteStaticMembers = {"org.assertj.core.api.Assertions.assertThat", "org.assertj.core.api.Assertions.assertThatThrownBy", "org.assertj.core.api.Assertions.assertThatExceptionOfType", "org.assertj.core.api.Assertions.catchThrowable", "org.hamcrest.MatcherAssert.assertThat", "org.hamcrest.Matchers.*", "org.hamcrest.CoreMatchers.*", "org.junit.jupiter.api.Assertions.*", "java.util.Objects.requireNonNull", "java.util.Objects.requireNonNullElse", "org.mockito.Mockito.*"}
  local code_generation_template = "${object.className}{${member.name()}=${member.value} ${otherMembers}}"
  local java_configuration = {eclipse = {downloadSources = true}, maven = {downloadSources = true}, implementationsCodeLens = {enabled = true}, referencesCodeLens = {enabled = true}, references = {includeDecompiledSources = true}, inlayHints = {parameterNames = {enabled = "all"}}, format = {enabled = false}, completion = {favoriteStaticMembers = favoriteStaticMembers}, signatureHelp = {enabled = true}, contentProvider = {preferred = "fernflower"}, sources = {organizeImports = {starThreshold = 999, staticStarThreshold = 9999}}, codeGeneration = {toString = {template = code_generation_template}, useBlocks = true}}
  local jdtls_config = {cmd = cmd, root_dir = root_dir, settings = {java = java_configuration}, init_options = {extendedClientCapabilities = extendedClientCapabilities}, autostart = true, flags = {allow_incremental_sync = true, debounce_text_changes = 150, server_side_fuzzy_completion = true}}
  local function jdtls_on_attach(client, bufnr)
    on_attach(client, bufnr)
    return jdtls_setup.add_commands()
  end
  local function setup_jdtls()
    jdtls_config.on_attach = jdtls_on_attach
    jdtls_config.capabilities = make_capabilities()
    return jdtls.start_or_attach(jdtls_config)
  end
  return setup_jdtls()
else
  return nil
end