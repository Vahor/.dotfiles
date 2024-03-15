return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
        lualine_c = { { 'harpoon2', indicators = { '1', '2', '3', '4' }, active_indicators = { '[1]', '[2]', '[3]', '[4]' } } },
      },
    },
  },
  {
    'letieu/harpoon-lualine',
    dependencies = {
      'nvim-lualine/lualine.nvim',
      {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
      },
    },
  },
}
