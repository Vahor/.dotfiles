vim.g.diffs = {
  integrations = {
    gitsigns = true,
  },
}

return {
  {
    'barrettruth/diffs.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
  },
}
