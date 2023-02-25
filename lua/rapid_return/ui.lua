-- TODO Use telescope to present all saved cursors

-- Imports
local stack = require('rapid_return.stack')
local cmd = require('rapid_return.cmd')

local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local M = {}

function M.history(opts)
  -- Show all the saved cursors and allow you to pick 
  -- one to jump to.
  -- Currently, no options are supported
  opts = opts or {}
  local entries = stack.get_items()

  -- TODO Previewer
  
  local attach_mappings = function(prompt_bufnr, map)
    actions.select_default:replace(function ()
      local entry = action_state.get_selected_entry()

      print(entry.index)

      actions.close(prompt_bufnr)

      cmd.go_to(entry.index)
    end)
    return true
  end

  pickers.new(opts, {
    prompt_title = 'Saved Cursors',
    finder = finders.new_table {
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.file .. ': Line ' .. entry.line,
          ordinal = entry.file .. ':' .. entry.line -- TODO Needed
        }
      end
    },
    --previewer = previewer
    attach_mappings = attach_mappings
  }):find()

end

return M
