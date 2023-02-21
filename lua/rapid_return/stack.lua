local stack = {}

local items = {}

function stack.push(item)
    table.insert(items, item)
end

function stack.pop()
    if #items == 0 then
        return nil
    end
    return table.remove(items)
end

function stack.size()
    return #items
end

function stack.top()
    if #items == 0 then
        return nil
    end
    return items[#items]
end

function stack.clear()
    items = {}
end

return stack
