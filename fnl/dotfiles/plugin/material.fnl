(module dotfiles.plugin.material
  {autoload {material material}})

(material.setup
      {:borders true
       :high_visibility {:darker true}})

(set vim.g.material_style :darker)
(vim.cmd "colorscheme material")
