
M = {}

function M.clear_virtual_text(line)
  vim.api.nvim_buf_clear_namespace(0, 0, line - 1, line)
  vim.api.nvim_buf_set_virtual_text(0, 0, line - 1, {}, {})
end

return M
