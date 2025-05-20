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
}
