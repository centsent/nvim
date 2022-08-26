local has_impatient, impatient = pcall(require, "impatient")
if has_impatient and impatient ~= nil then
  impatient.enable_profile()
end

-- Basic options for neovim
require("options")
-- Keymaps
require("keymaps")
-- The plugins that I use
require("plugins")
