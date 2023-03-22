local stack = require("rapid_return.stack")
local util = require("rapid_return.util")

local M = {}

local text = "⚓" -- text to display

function M.save()
  local top = stack.top()

  if top then
    if top[1] == vim.fn.line('.') and top[2] == vim.fn.col('.') then
      print("Already stored this cursor position")
      return
    end
  end

  stack.push({
    line = vim.fn.line('.'),
    col = vim.fn.col('.'), 
    file = vim.fn.expand('%'),
    index = stack.size() + 1
  })

  -- Set cursor locations
  vim.api.nvim_buf_set_virtual_text(0, 0, vim.fn.line('.') - 1, {{text .. stack.size(), "LineNr"}}, {})
end

function M.rewind()
  local pos = stack.pop()

  if pos then
    vim.cmd('edit ' .. pos.file)
    vim.fn.cursor(pos.line, pos.col)

    -- Remove cursor locations
    util.clear_virtual_text(pos.line)
  else
    print("No more cursors to pop")
  end
end

function M.rewind_all()
  for _ = 1, stack.size() do
    local pos = stack.pop()
    util.clear_virtual_text(pos.line)

    if stack.top() == nil then
      vim.cmd('edit ' .. pos.file)
      vim.fn.cursor(pos.line, pos.col)
    end
  end
end

function M.forward()
  if stack.is_at_end() then
    print("Already at the last cursor")
    return
  end

  stack.advance()

  local pos = stack.top()

  if vim.fn.expand('%') ~= pos.file then
    vim.cmd('edit ' .. pos.file)
  end
  vim.fn.cursor(pos.line, pos.col)

  -- Set cursor locations
  vim.api.nvim_buf_set_virtual_text(0, 0, vim.fn.line('.') - 1, {{text .. stack.size(), "LineNr"}}, {})
end

function M.clear()

  for _ = 1, stack.size() do
    local pos = stack.pop()
    util.clear_virtual_text(pos.line)
  end

  -- True clear
  stack.clear()

  print("Cleared all cursors")
end

function M.go_to(index)
  if index == nil then
    print('Index not provided')
    return
  end

  if index > stack.size() then
    print('Index out of bounds')
    return
  end

  for i = index + 1, stack.size() do
    local pos = stack.pop()
    util.clear_virtual_text(pos.line)
  end

  local pos = stack.pop()

  if vim.fn.expand('%') ~= pos.file then
    vim.cmd('edit ' .. pos.file)
  end
  vim.fn.cursor(pos.line, pos.col)

  util.clear_virtual_text(pos.line)

end

return M
