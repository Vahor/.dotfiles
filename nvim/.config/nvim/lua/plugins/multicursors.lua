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

    -- Add cursors on visual selection
    set('x', 'I', mc.insertVisual)
    set('x', 'A', mc.appendVisual)

    -- Add all matches in the document
    set({ 'n', 'x' }, '<leader>ma', mc.matchAllAddCursors, { desc = '[M]ulticursors: [A]dd all matches' })

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
      layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)

      -- Delete the main cursor.
      layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor)

      -- Enable and clear cursors using escape.
      layerSet('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

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
