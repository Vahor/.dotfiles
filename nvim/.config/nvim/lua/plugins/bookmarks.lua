return {
  'LintaoAmons/bookmarks.nvim',
  tag = 'v2.9.1',
  dependencies = {
    { 'kkharji/sqlite.lua' },
    { 'nvim-telescope/telescope.nvim' },
    { 'stevearc/dressing.nvim' }, -- optional: better UI
  },
  config = function()
    local opts = {
      signs = {
        mark = {
          color = 'lightgray',
          line_bg = '#35364c',
        },
      },
    } -- check the "./lua/bookmarks/default-config.lua" file for all the options
    local bookmarks = require 'bookmarks'
    bookmarks.setup(opts) -- you must call setup to init sqlite db

    vim.api.nvim_create_user_command('DeleteBookmarkAtCursor', function()
      local location = require('bookmarks.domain.location').get_current_location()
      local node = require('bookmarks.domain.repo').find_node_by_location(location)
      if not node then
        vim.notify('No node found at cursor position', vim.log.levels.WARN)
        return
      end
      vim.notify('Deleting bookmark ' .. node.name, vim.log.levels.INFO)
      require('bookmarks.domain.service').delete_node(node.id)
      require('bookmarks.sign').safe_refresh_signs()
    end, { desc = 'Remove the bookmark at cursor line.' })

    vim.keymap.set('n', '<leader>sm', '<cmd>BookmarksGoto<cr>', { desc = '[S]earch [B]ookmarks' })
    vim.keymap.set('n', '<leader>mm', '<cmd>BookmarksMark<cr>', { desc = 'Book[m]arks add' })
    vim.keymap.set('n', '<leader>dm', '<cmd>DeleteBookmarkAtCursor<cr>', { desc = 'Book[m]arks [d]elete' })
  end,
}
