return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'dokwork/lualine-ex' },
    opts = {
      sections = {
        lualine_a = { {
          'mode',
          fmt = function(res)
            return res:sub(1, 3)
          end,
        } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          { 'harpoon2', indicators = { '1', '2', '3', '4' }, active_indicators = { '[1]', '[2]', '[3]', '[4]' } },
          {
            'ex.relative_filename',
            max_length = 0.5,
          },
        },
        lualine_x = { 'filetype' },
        lualine_y = {},
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
