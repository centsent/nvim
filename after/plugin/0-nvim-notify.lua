-- :fennel:1668308444
local has_notify_3f, notify = pcall(require, "notify")
if has_notify_3f then
  local settings = {background_colour = "#121212", max_width = 80}
  notify.setup(settings)
  vim.notify = notify
  return vim.api.nvim_set_keymap("n", "<leader>n", "", {callback = notify.dismiss})
else
  return nil
end