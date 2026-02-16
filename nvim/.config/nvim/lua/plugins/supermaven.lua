return {
  {
    'supermaven-inc/supermaven-nvim',
    enabled = false, -- testing other plugins
    config = function()
      require('supermaven-nvim').setup {
        log_level = 'off',
        keymaps = {
          accept_suggestion = '<Tab>',
          clear_suggestion = '<C-]>',
          accept_suggestion_and_insert = '<C-j>',
        },
      }
    end,
  },
}
