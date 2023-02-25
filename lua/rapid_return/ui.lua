-- TODO Use telescope to present all saved cursors

-- Imports
local stack = require('rapid_return.stack')

local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

local M = {}

function M.history(opts)
  -- Show all the saved cursors and allow you to pick 
  -- one to jump to.
  -- Currently, no options are supported
  opts = opts or {}
  local entries = stack.get_all()

  pickers.new(opts, {
    prompt_title = 'Saved Cursors',
    finder = finders.new_table {
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[3] .. ': Line ' .. entry[1],
          ordinal = entry[3] .. ':' .. entry[1] -- TODO Needed?
        }
      end
    }
  }):find()

end

return M
