(let [(has-jdtls jdtls) (pcall require :jdtls)]
  (when has-jdtls
    (local jdtls-setup (require :jdtls.setup))
    (local home (os.getenv :HOME))
    (local data-path (vim.fn.stdpath :data))
    (local project-name (vim.fn.fnamemodify (vim.fn.getcwd) ":p:h:t"))
    (local workspace-dir (.. (.. home :/.cache/jdtls-workspace/) project-name))
    (local jdtls-install-dir (.. data-path :/mason/packages/jdtls))
    (local jdtls-jar
           (vim.fn.glob (.. jdtls-install-dir
                            :/plugins/org.eclipse.equinox.launcher_*.jar)))
    (local root-dir (jdtls-setup.find_root [:.git :mvnw :gradlew]))
    (local extendedClientCapabilities jdtls.extendedClientCapabilities)
    (set extendedClientCapabilities.resolveAdditionalTextEditsSupport true)
    (local cmd [:java
                :-Declipse.application=org.eclipse.jdt.ls.core.id1
                :-Dosgi.bundles.defaultStartLevel=4
                :-Declipse.product=org.eclipse.jdt.ls.core.product
                :-Dlog.protocol=true
                :-Dlog.level=ALL
                :-Xms1g
                :--add-modules=ALL-SYSTEM
                :--add-opens
                :java.base/java.util=ALL-UNNAMED
                :--add-opens
                :java.base/java.lang=ALL-UNNAMED
                :-jar
                jdtls-jar
                :-configuration
                (.. jdtls-install-dir :/config_linux)
                :-data
                workspace-dir])
    (local favoriteStaticMembers
           [:org.assertj.core.api.Assertions.assertThat
            :org.assertj.core.api.Assertions.assertThatThrownBy
            :org.assertj.core.api.Assertions.assertThatExceptionOfType
            :org.assertj.core.api.Assertions.catchThrowable
            :org.hamcrest.MatcherAssert.assertThat
            :org.hamcrest.Matchers.*
            :org.hamcrest.CoreMatchers.*
            :org.junit.jupiter.api.Assertions.*
            :java.util.Objects.requireNonNull
            :java.util.Objects.requireNonNullElse
            :org.mockito.Mockito.*])
    (local code-generation-template
           "${object.className}{${member.name()}=${member.value} ${otherMembers}}")
    (local java-configuration
           {:eclipse {:downloadSources true}
            :maven {:downloadSources true}
            :implementationsCodeLens {:enabled true}
            :referencesCodeLens {:enabled true}
            :references {:includeDecompiledSources true}
            :inlayHints {:parameterNames {:enabled :all}}
            :format {:enabled false}
            :completion {: favoriteStaticMembers}
            :signatureHelp {:enabled true}
            :contentProvider {:preferred :fernflower}
            :sources {:organizeImports {:starThreshold 999
                                        :staticStarThreshold 9999}}
            :codeGeneration {:toString {:template code-generation-template}
                             :useBlocks true}})
    (local jdtls-config
           {: cmd
            :root_dir root-dir
            :settings {:java java-configuration}
            ;; Language server `initializationOptions`
            ;; You need to extend the `bundles` with paths to jar files
            ;; if you want to use additional eclipse.jdt.ls plugins.
            ;;
            ;; See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
            ;;
            ;; If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
            :init_options {: extendedClientCapabilities}
            :autostart true
            :flags {:allow_incremental_sync true
                    :debounce_text_changes 150
                    :server_side_fuzzy_completion true}})

    (fn setup-jdtls []
      (set jdtls-config.on_attach #(jdtls-setup.add_commands))
      (jdtls.start_or_attach jdtls-config))

    (setup-jdtls)))

