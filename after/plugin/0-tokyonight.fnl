(let [(has_tokyonight? tokyonight) (pcall require :tokyonight)]
  (when has_tokyonight?
    (local tokyonight_settings {
      :tokyonight_transparent_sidebar true
      :transparent true
      :styles {
        :functions "italic"
        :sidebars "transparent"
        :float "transparent"
      }
    })

    (tokyonight.setup tokyonight_settings)
    (vim.cmd "colorscheme tokyonight")))
