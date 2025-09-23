local signs = {
  Error = " ",
  Warning = " ",
  Hint = " ",
  Information = " "
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.diagnostic.config({ signs = { text = icon, texthl = hl, numhl = hl } })
end
