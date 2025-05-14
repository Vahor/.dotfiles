return {
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {
      modes = {
        diagnostics = {
          auto_open = false,
          auto_close = true,
          auto_preview = true,
          focus = true,
          open_no_results = true,
        },
        split_diagnostics = {
          mode = 'diagnostics',
          preview = {
            type = 'split',
            relative = 'win',
            position = 'right',
            size = 0.3,
          },
        },
      },
    },
    keys = {
      {
        '<leader>tT',
        '<cmd>Trouble split_diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>tt',
        '<cmd>Trouble split_diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>Q',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
      {
        '<leader>q',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
}
