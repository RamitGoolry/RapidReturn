local stack = {}

local items = {}
local cursor = 0

function stack.push(item)

  if cursor < #items then
    -- We are deleting all items after the cursor
    for i = #items, cursor + 1, -1 do
      table.remove(items, i)
    end
  end

  table.insert(items, item)
  cursor = cursor + 1
end

function stack.pop()
    if cursor == 0 then
        return nil
    end

    -- We are delayinng deletion of the item until the next push to enable
    -- forward
    cursor = cursor - 1

    return items[cursor + 1]
end

function stack.size()
    return cursor
end

function stack.is_at_end()
  return cursor == #items
end

function stack.advance() 
  cursor = cursor + 1
end

function stack.top()
    if #items == 0 then
        return nil
    end
    return items[cursor]
end

function stack.clear()
    items = {}
end

return stack
