-- :fennel:1679885025
local function augroup(name)
  return vim.api.nvim_create_augroup(("me_" .. name), {clear = true})
end
local function create_autocmd(autocmd)
  return vim.api.nvim_create_autocmd(autocmd.events, autocmd.opts)
end
local function set_lastloc()
  local mark = vim.api.nvim_buf_get_mark(0, "\"")
  local lcount = vim.api.nvim_buf_line_count(0)
  local last_mark = mark[1]
  if ((last_mark > 0) and (last_mark <= lcount)) then
    return pcall(vim.api.nvim_win_set_cursor, 0, mark)
  else
    return nil
  end
end
local function close_with_q(event)
  return vim.bo[event.buf].buflisted
end
local autocmds
local function _2_()
  return vim.highlight.on_yank()
end
autocmds = {{events = {"TextYankPost"}, opts = {group = augroup("highlight_yank"), callback = _2_}}, {events = {"BufReadPost"}, opts = {group = augroup("last_loc"), callback = set_lastloc}}, {events = {"FileType"}, opts = {group = augroup("close_with_q"), pattern = {"PlenaryTestPopup", "help", "lspinfo", "man", "notify", "qf", "spectre_panel", "startuptime"}, callback = close_with_q}}}
for index_4_auto, val_5_auto in ipairs(autocmds) do
  create_autocmd(val_5_auto, index_4_auto)
end
return nil