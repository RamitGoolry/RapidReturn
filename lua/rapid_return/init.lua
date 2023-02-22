local rapid_return = require("rapid_return")
local stack = require("rapid_return.stack")

function push_cursor()
  stack.push({vim.fn.line("."), vim.fn.col(".")})
end

function pop_cursor()
  local pos = stack.pop()

  if pos then
    vim.fn.cursor(pos[1], pos[2])
  else
    vim.api.nvim_err_write("No more cursors to pop")
    print("No more cursors to pop")
  end
end

return {
  push_cursor = push_cursor,
  pop_cursor = pop_cursor
}
