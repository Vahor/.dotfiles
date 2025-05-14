return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        numhl = true,
        sign_priority = 15, -- higher than diagnostic,todo signs. lower than dapui breakpoint sign
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }

      vim.keymap.set('n', '<leader>gs', function()
        vim.cmd 'Gitsigns toggle_deleted'
        vim.cmd 'Gitsigns toggle_linehl'
      end, { desc = 'Toggle git signs' })

      vim.keymap.set('n', '<leader>gb', function()
        vim.cmd 'Gitsigns blame_line'
      end, { desc = 'Blame the current line' })
    end,
  },
}
