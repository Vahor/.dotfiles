-- <leadertm to toggle table mode

vim.api.nvim_create_autocmd({ 'BufRead' }, {
  desc = 'Fix markdown syntax highlighting',
  group = vim.api.nvim_create_augroup('markdown-syntax', { clear = true }),
  pattern = { '*.md', '*.mdx' },
  callback = function()
    vim.cmd [[
      set syntax=markdown
      set filetype=markdown
    ]]
  end,
})

return {
  {
    'dhruvasagar/vim-table-mode',
  },
}
