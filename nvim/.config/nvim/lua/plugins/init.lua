return {
  {
    -- add color on hex, rgb, hsl, css colors
    'catgoose/nvim-colorizer.lua',
    name = 'nvim-colorizer-catgoose',
    opts = {},
  },
  {
    'dmmulroy/ts-error-translator.nvim',
    config = function()
      require('ts-error-translator').setup()
    end,
  },
}
