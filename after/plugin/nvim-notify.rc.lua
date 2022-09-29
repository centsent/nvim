local has_notify, notify = pcall(require, "notify")
if not has_notify then
  return
end

local settings = {
  background_colour = "#121212",
  max_width = 80,
}

local setup = function(user_opts)
  notify.setup(user_opts)
  vim.notify = notify
  vim.api.nvim_set_keymap("n", "<leader>n", "", { callback = notify.dismiss })
end

setup(settings)
