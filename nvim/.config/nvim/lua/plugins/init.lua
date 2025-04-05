return {
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
}
