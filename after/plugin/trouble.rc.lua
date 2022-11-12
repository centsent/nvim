local has_trouble, trouble = pcall(require, "trouble")
if not has_trouble then
  return
end

local settings = {
  position = "right",
  use_diagnostic_signs = true,
}

trouble.setup(settings)
