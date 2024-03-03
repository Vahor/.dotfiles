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
  { 'dmmulroy/ts-error-translator.nvim' },
  {
    'zbirenbaum/copilot.lua',
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<c-y>',
          next = '<c-n>',
          prev = '<c-p>',
        },
      },
    },
  },
}
