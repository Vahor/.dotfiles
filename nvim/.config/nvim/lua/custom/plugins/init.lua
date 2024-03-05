-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  { 'dmmulroy/ts-error-translator.nvim' },
  { 'windwp/nvim-ts-autotag' },
  { 'windwp/nvim-autopairs' },
  {
    'hiphish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      require('rainbow-delimiters.setup').setup {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
        },
        query = {
          tsx = 'rainbow-parens',
          javascript = 'rainbow-parens',
        },
      }
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
  },
  {
    'zbirenbaum/copilot.lua',
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<Tab>', -- Tab for copilot and ctrl-y for completion
          next = '<c-n>',
          prev = '<c-p>',
        },
      },
    },
  },
}
