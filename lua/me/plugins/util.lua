-- :fennel:1678787918
local function _1_()
  vim.g.startuptime_tries = 10
  return nil
end
return {{cmd = "StartupTime", config = _1_, "dstein64/vim-startuptime"}, {"nvim-lua/plenary.nvim"}, {event = {"CursorMoved"}, "wakatime/vim-wakatime"}}