local stack = require("stack")

local M = {}

function push_cursor()
  stack.push({vim.fn.line("."), vim.fn.col(".")})
end

function pop_cursor()
  local pos = stack.pop()
  if pos then
    vim.fn.cursor(pos[1], pos[2])
  end
end
