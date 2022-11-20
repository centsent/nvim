if not vim.filetype then
  return
end

vim.filetype.add({
  extension = {
    lock = "yaml",
  },
  filename = {
    ["go.mod"] = "gomod",
    Podfile = "ruby",
    Brewfile = "ruby",
  },
  pattern = {
    [".*%.gradle"] = "groovy",
    [".*%.env%..*"] = "env",
  },
})
