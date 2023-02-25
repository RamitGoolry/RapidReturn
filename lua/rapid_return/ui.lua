-- Imports
local stack = require('rapid_return.stack')
local cmd = require('rapid_return.cmd')

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local M = {}

function M.history(opts)
  -- Show all the saved cursors and allow you to pick 
  -- one to jump to.
  -- Currently, no options are supported
  opts = opts or {}
  local entries = stack.get_items()

  local previewer = previewers.new_buffer_previewer {
    title = 'File Preview',
    get_buffer_by_name = function(_, entry)
      return entry.value.file
    end,
    define_preview = function(self, entry, _)
      local bufnr = self.state.bufnr
      local file = entry.value.file
      local line = entry.value.line
      local column = entry.value.col

      -- Extract the filetype from the file extension
      local filetype = vim.fn.fnamemodify(file, ':e')

      -- Read the file into the buffer and have syntax highlightning enabled
      vim.api.nvim_buf_set_option(bufnr, 'filetype', filetype)
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.readfile(file))

      -- Highlight the whole line
      vim.api.nvim_buf_add_highlight(bufnr, -1, 'CursorLine', line - 1, 0, -1)
    end
  }

  --local previewer = previewers.vim_buffer_cat.new(opts)

  local attach_mappings = function(prompt_bufnr, map)
    actions.select_default:replace(function ()
      local entry = action_state.get_selected_entry()
      actions.close(prompt_bufnr)
      cmd.go_to(entry.index)
    end)
    return true
  end

  pickers.new(opts, {
    prompt_title = 'Cursor History',
    finder = finders.new_table {
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.file .. ': Line ' .. entry.line,
          ordinal = entry.file .. ': Line ' .. entry.line
        }
      end
    },
    previewer = previewer,
    attach_mappings = attach_mappings
  }):find()

end

return M
