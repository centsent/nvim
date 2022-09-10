local has_jdtls, jdtls = pcall(require, "jdtls")
if not has_jdtls then
  return
end

local jdtls_setup = require("jdtls.setup")
local mylsp = require("me.lsp")
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls-workspace" .. project_name
local jdtls_install_dir = home .. "/.local/share/nvim/mason/packages/jdtls"
local launcher_version = "1.6.400.v2021024-0641"
local root_dir = jdtls_setup.find_root({ ".git", "mvnw", "gradlew" })
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xms1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens",
  "java.base/java.util=ALL-UNNAMED",
  "--add-opens",
  "java.base/java.lang=ALL-UNNAMED",

  "-jar",
  jdtls_install_dir .. "/plugins/org.eclipse.equinox.launcher_" .. launcher_version .. ".jar",
  "-configuration",
  jdtls_install_dir .. "/config_linux",
  "-data",
  workspace_dir,
}

-- Here you can configure eclipse.jdt.ls specific settings
-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
-- for a list of options
local java_configuration = {
  eclipse = {
    downloadSources = true,
  },
  maven = {
    downloadSources = true,
  },
  implementationsCodeLens = {
    enabled = true,
  },
  referencesCodeLens = {
    enabled = true,
  },
  references = {
    includeDecompiledSources = true,
  },
  inlayHints = {
    parameterNames = {
      enabled = "all", -- literals, all, none
    },
  },
  format = {
    enabled = false,
  },
  completion = {
    favoriteStaticMembers = {
      "org.assertj.core.api.Assertions.assertThat",
      "org.assertj.core.api.Assertions.assertThatThrownBy",
      "org.assertj.core.api.Assertions.assertThatExceptionOfType",
      "org.assertj.core.api.Assertions.catchThrowable",
      "org.hamcrest.MatcherAssert.assertThat",
      "org.hamcrest.Matchers.*",
      "org.hamcrest.CoreMatchers.*",
      "org.junit.jupiter.api.Assertions.*",
      "java.util.Objects.requireNonNull",
      "java.util.Objects.requireNonNullElse",
      "org.mockito.Mockito.*",
    },
  },
  signatureHelp = { enabled = true },
  contentProvider = { preferred = "fernflower" },
  sources = {
    organizeImports = {
      starThreshold = 999,
      staticStarThreshold = 9999,
    },
  },
  codeGeneration = {
    toString = {
      template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
    },
    useBlocks = true,
  },
}

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = cmd,
  root_dir = root_dir,
  settings = {
    java = java_configuration,
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    --bundles = {},
    extendedClientCapabilities = extendedClientCapabilities,
  },
  autostart = true,
  flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
    server_side_fuzzy_completion = true,
  },
}

config.on_attach = function(client, bufnr)
  mylsp.on_attach(client, bufnr)
  jdtls_setup.add_commands()
end

config.capabilities = mylsp.make_capabilities()
jdtls.start_or_attach(config)
