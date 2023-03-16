(local lua_ls-settings
       {:settings {:Lua {:completion {:callSnippet :Replace}
                         :diagnostics {:globals [:vim]}
                         :workspace {:checkThirdParty false
                                     :library (vim.api.nvim_get_runtime_file ""
                                                                             true)}
                         :runtime {:version :LuaJIT}}}})

{1 :neovim/nvim-lspconfig
 :dependencies [;; Dev setup for init.lua and plugin development with full signature help docs and completion for the nvim lua API.
                {1 :folke/neodev.nvim
                 :opts {:experimental {:pathStrict true}}
                 :config true}]
 :opts {:servers {:lua_ls lua_ls-settings}}}

