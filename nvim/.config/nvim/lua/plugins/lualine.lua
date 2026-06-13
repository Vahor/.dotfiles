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
        lualine_b = {
          {
            'branch',
            icon = '',
            color = { gui = 'bold' },
          },
        },
        lualine_c = {
          {
            'diff',
            symbols = { added = '+ ', modified = '= ', removed = '- ' },
            diff_color = {
              added = { fg = '#a7c080' },
              modified = { fg = '#ffdf1b' },
              removed = { fg = '#ff6666' },
            },
          },

          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' ',
            },
            diagnostics_color = {
              error = { fg = '#ff6666' },
              warn = { fg = '#ffdf1b' },
              info = { fg = '#82aaff' },
              hint = { fg = '#c792ea' },
            },
          },

          {
            'ex.relative_filename',
            max_length = 0.5,
          },
          { 'lsp_progress' },
        },
        lualine_x = { 'filetype' },
        lualine_y = {},
      },
    },
  },
}
