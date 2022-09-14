local has_gitsigns, gitsigns = pcall(require, "gitsigns")
if not has_gitsigns then
  return
end

local settings = {
  current_line_blame = true,
  numhl = true,
  word_diff = true,
}

local setup = function(user_config)
  gitsigns.setup(user_config)
end

setup(settings)
