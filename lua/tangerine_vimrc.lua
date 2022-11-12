-- :fennel:1668246343
local has_impatient_3f, impatient = pcall(require, "impatient")
if has_impatient_3f then
  impatient.enable_profile()
else
end
require("options")
require("keymaps")
require("plugins")
return nil