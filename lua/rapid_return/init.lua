local stack = require("rapid_return.stack")

local M = {}

local text = "⚓" -- text to display

function M.push_cursor()
  local top = stack.top()

  if top then
    if top[1] == vim.fn.line('.') and top[2] == vim.fn.col('.') then
      print("Already stored this cursor position")
      return
    end
  end

  stack.push({vim.fn.line('.'), vim.fn.col('.'), vim.fn.expand('%')})

  -- Set cursor locations
  vim.api.nvim_buf_set_virtual_text(0, 0, vim.fn.line('.') - 1, {{text .. stack.size(), "LineNr"}}, {})
end

function M.pop_cursor()
  local pos = stack.pop()

  if pos then
    vim.cmd('edit ' .. pos[3])
    vim.fn.cursor(pos[1], pos[2])

    -- Remove cursor locations
    vim.api.nvim_buf_clear_namespace(0, 0, pos[1] - 1, pos[1])
    vim.api.nvim_buf_set_virtual_text(0, 0, pos[1] - 1, {}, {})
  else
    vim.api.nvim_err_write("No more cursors to pop")
    print("No more cursors to pop")
  end
end

function M.clear()
  stack.clear()
  -- TODO Clear all signs
  print("Cleared all cursors")
end

return M
