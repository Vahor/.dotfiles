return {
  {
    'mvllow/modes.nvim',
    tag = 'v0.2.1',
    config = function()
      require('modes').setup {
        line_opacity = 0.20,
      }
    end,
  },
}
