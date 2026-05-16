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
        on_attach = function(bufnr)
          local gitsigns = require 'gitsigns'

          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          map('n', '<leader>gp', gitsigns.preview_hunk, 'Preview hunk')
          map('x', '<leader>gr', ':Gitsigns reset_hunk<CR>', 'Reset visual selection')
          map('n', '<leader>gb', function()
            gitsigns.blame_line { full = true }
          end, 'Blame current line')
          map('n', '<leader>gB', gitsigns.toggle_current_line_blame, 'Toggle line blame')

          map('n', '<leader>gs', function()
            vim.cmd 'Gitsigns toggle_deleted'
            vim.cmd 'Gitsigns toggle_linehl'
          end, 'Show diff (toggle)')
        end,
      }
    end,
  },
}
