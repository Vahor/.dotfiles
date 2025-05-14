return {
  'mbbill/undotree',

  config = function()
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [u]ndo tree' })

    vim.g.undotree_WindowLayout = 2
    vim.g.unditree_ShortIndicators = 1
    vim.g.undotree_DiffpanelHeight = 15
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
