---@module "lazy"
---
---@type LazySpec
return {
  'jake-stewart/multicursor.nvim',
  config = function()
    local mc = require 'multicursor-nvim'

    mc.setup()

    local set = vim.keymap.set

    -- bring back cursors if you accidentally clear them
    set('n', '<leader>mr', mc.restoreCursors, { desc = '[M]ulticursors: [R]estore cursors' })
    --
    -- Add all matches in the document
    set({ 'n', 'x' }, '<leader>ma', mc.matchAllAddCursors, { desc = '[M]ulticursors: [A]dd all matches' })

    set({ 'n', 'x' }, '<leader>mn', function()
      mc.matchAddCursor(1)
    end, { desc = '[M]ulticursors: add [N]ext match' })
    set({ 'n', 'x' }, '<leader>ms', function()
      mc.matchSkipCursor(1)
    end, { desc = '[M]ulticursors: [S]kip skip match' })
    set({ 'n', 'x' }, '<leader>mN', function()
      mc.matchAddCursor(-1)
    end, { desc = '[M]ulticursors: add previous match (inverse of [N])' })
    set({ 'n', 'x' }, '<leader>mS', function()
      mc.matchSkipCursor(-1)
    end, { desc = '[M]ulticursors: skip previous match (inverse of [S])' })

    -- Disable cursors
    set('n', '<leader>md', function()
      if mc.hasCursors() then
        mc.clearCursors()
      end
    end, { desc = '[M]ulticursors: [D]isable' })

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, 'MultiCursorCursor', { link = 'Cursor' })
    hl(0, 'MultiCursorVisual', { link = 'Visual' })
    hl(0, 'MultiCursorSign', { link = 'SignColumn' })
    hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
    hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
  end,
}
