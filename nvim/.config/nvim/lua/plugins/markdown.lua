-- <leadertm to toggle table mode

vim.api.nvim_create_autocmd({ 'BufRead' }, {
  desc = 'Fix markdown syntax highlighting',
  group = vim.api.nvim_create_augroup('markdown-syntax', { clear = true }),
  pattern = { '*.md', '*.mdx' },
  callback = function()
    vim.cmd [[
      set syntax=markdown
      set filetype=markdown
    ]]
  end,
})

vim.g.table_mode_corner = '|'
vim.g.table_mode_map_prefix = '<leader>tm'
vim.g.table_mode_tableize_map = '<leader>tc'
vim.g.table_mode_delete_row_map = '<leader>tdr'

return {
  {
    'dhruvasagar/vim-table-mode',
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,

    dependencies = {
      -- You may not need this if you don't lazy load
      -- Or if the parsers are in your $RUNTIMEPATH
      'nvim-treesitter/nvim-treesitter',

      'saghen/blink.cmp',
    },
    opts = function()
      local presets = require 'markview.presets'
      vim.keymap.set('n', '<leader>mt', function()
        vim.cmd 'Markview splitToggle'
      end, { desc = '[M]arkview: [T]oggle' })

      return {
        markdown = {
          tables = presets.tables.single,
          horizontal_rules = presets.horizontal_rules.thin,
        },
        preview = {
          enable = false,
        },
      }
    end,
  },
}
