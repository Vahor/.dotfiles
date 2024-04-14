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
    -- add color on hex, rgb, hsl, css colors
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'dmmulroy/ts-error-translator.nvim',
    config = function()
      require('ts-error-translator').setup()
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    opt = {
      autotag = {
        enable_close = false,
      },
    },
  },
  { 'windwp/nvim-autopairs' },
  -- {
  --   'hiphish/rainbow-delimiters.nvim',
  --   config = function()
  --     local rainbow_delimiters = require 'rainbow-delimiters'
  --     require('rainbow-delimiters.setup').setup {
  --       strategy = {
  --         [''] = rainbow_delimiters.strategy['global'],
  --       },
  --       query = {
  --         tsx = 'rainbow-parens',
  --         javascript = 'rainbow-parens',
  --       },
  --     }
  --   end,
  -- },
}
--
