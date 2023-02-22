local stack = require("rapid_return.stack")

local M = {}

local text = "⚓" -- text to display

function M.push_cursor() -- TODO Rename to save
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

function M.pop_cursor() -- TODO Rename to back
  local pos = stack.pop()

  if pos then
    vim.cmd('edit ' .. pos[3])
    vim.fn.cursor(pos[1], pos[2])

    -- Remove cursor locations
    vim.api.nvim_buf_clear_namespace(0, 0, pos[1] - 1, pos[1])
    vim.api.nvim_buf_set_virtual_text(0, 0, pos[1] - 1, {}, {})
  else
    print("No more cursors to pop")
  end
end

function M.forward()
  if stack.is_at_end() then
    print("Already at the last cursor")
    return
  end

  stack.advance()


  local pos = stack.top()

  vim.cmd('edit ' .. pos[3])
  vim.fn.cursor(pos[1], pos[2])

  -- Set cursor locations
  vim.api.nvim_buf_set_virtual_text(0, 0, vim.fn.line('.') - 1, {{text .. stack.size(), "LineNr"}}, {})
end

function M.clear()

  for i = 1, stack.size() do
    local pos = stack.pop()
    vim.api.nvim_buf_clear_namespace(0, 0, pos[1] - 1, pos[1])
    vim.api.nvim_buf_set_virtual_text(0, 0, pos[1] - 1, {}, {})
  end

  -- True clear
  stack.clear()

  print("Cleared all cursors")
end

return M
