vim.api.nvim_create_autocmd({ 'BufRead' }, {
  desc = 'Fix envrc syntax highlighting',
  group = vim.api.nvim_create_augroup('envrc-syntax-highlighting', { clear = true }),
  pattern = { '.envrc' },
  callback = function()
    vim.cmd [[
      set syntax=bash
      set filetype=bash
    ]]
  end,
})

return {}
