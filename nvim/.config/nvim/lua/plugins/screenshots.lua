return {
  {
    'TobinPalmer/rayso.nvim',
    cmd = { 'Rayso' },
    config = function()
      require('rayso').setup {
        options = {
          theme = 'tailwind',
        },
      }
    end,
  },
}
