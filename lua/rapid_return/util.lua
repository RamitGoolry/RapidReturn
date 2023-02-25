
M = {}

function M.clear_virtual_text(line)
  vim.api.nvim_buf_clear_namespace(0, 0, line - 1, line)
  vim.api.nvim_buf_set_virtual_text(0, 0, line - 1, {}, {})
end

M.extension_map = {
  ['py'] = 'python',
  ['js'] = 'javascript',
  ['jsx'] = 'javascriptreact',
  ['ts'] = 'typescript',
  ['tsx'] = 'typescriptreact',
  ['html'] = 'html',
  ['css'] = 'css',
  ['json'] = 'json',
  ['md'] = 'markdown',
  ['lua'] = 'lua',
  ['cpp'] = 'cpp',
  ['c'] = 'c',
  ['rs'] = 'rust',
  ['go'] = 'go',
  ['java'] = 'java',
  ['sh'] = 'sh',
  ['rb'] = 'ruby',
  ['php'] = 'php',
  ['pl'] = 'perl',
  ['hs'] = 'haskell',
  ['erl'] = 'erlang',
  ['ex'] = 'elixir',
  ['exs'] = 'elixir',
  ['kt'] = 'kotlin',
  ['dart'] = 'dart',
  ['vue'] = 'vue',
  ['scss'] = 'scss',
  ['sass'] = 'sass',
  ['yaml'] = 'yaml',
  ['yml'] = 'yaml',
  ['r'] = 'r',
  ['jl'] = 'julia',
  ['zsh'] = 'zsh'
}

return M
