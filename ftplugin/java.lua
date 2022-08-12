local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/workspace/java/" .. project_name
local jdtls_install_dir = home .. "/.local/share/nvim/mason/packages/jdtls"
local launcher_version = "1.6.400.v20210924-0641"
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
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
  },

  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
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
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      configuration = {
        runtimes = {
          --{
          --name = "JavaSE-1.8",
          --path = "/usr/lib/jvm/java-8-openjdk/",
          --},
          --{
          --name = "JavaSE-11",
          --path = "/usr/lib/jvm/java-11-openjdk/",
          --},
          --{
          --name = "JavaSE-17",
          --path = home .. "/.local/jdks/jdk-17.0.4+8/",
          --},
          --{
          --name = "JavaSE-18",
          --path = home .. "/.local/jdks/jdk-18.0.2+9/",
          --},
        },
      },
    },
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },
}

config.on_attach= function(client, bufnr)
  print("attached on java file \n trying to resolve workspace")
  require("plugin.lspconfig.rc").on_attach(client, bufnr)
  print("what the fuck")
end

jdtls.start_or_attach(config)
