return {
  -- {
  --   'zbirenbaum/copilot.lua',
  --   event = 'InsertEnter',
  --   build = ':Copilot auth',
  --   config = function()
  --     require('copilot').setup {
  --       filetypes = {
  --         markdown = true,
  --       },
  --       suggestion = {
  --         auto_trigger = true,
  --         keymap = {
  --           accept = false, -- Defined in the config below
  --           next = '<c-n>',
  --           prev = '<c-p>',
  --         },
  --       },
  --     }
  --     vim.keymap.set('i', '<Tab>', function()
  --       if require('copilot.suggestion').is_visible() then
  --         require('copilot.suggestion').accept()
  --       else
  --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
  --       end
  --     end, { desc = 'Super Tab' })
  --   end,
  -- },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<Tab>',
          clear_suggestion = '<C-]>',
          accept_suggestion_and_insert = '<C-j>',
        },
      }
    end,
  },
}
