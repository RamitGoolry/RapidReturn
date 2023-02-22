local stack = require("rapid_return.stack")

local M = {}

function M.push_cursor()
  local top = stack.top()

  if top then
    if top[1] == vim.fn.line('.') and top[2] == vim.fn.col('.') then
      print("Already stored this cursor position")
      return
    end

  stack.push({vim.fn.line('.'), vim.fn.col('.')})
end

function M.pop_cursor()
  local pos = stack.pop()

  if pos then
    vim.fn.cursor(pos[1], pos[2])
  else
    vim.api.nvim_err_write("No more cursors to pop")
    print("No more cursors to pop")
  end
end

return M
