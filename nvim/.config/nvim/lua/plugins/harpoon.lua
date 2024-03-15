return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon.setup {}

      -- Keymap
      vim.keymap.set('n', '<c-a>', function()
        harpoon:list():append()
      end)
      vim.keymap.set('n', '<c-space>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-Left>', function()
        harpoon:list():prev { ui_nav_wrap = true }
      end)
      vim.keymap.set('n', '<C-Right>', function()
        harpoon:list():next { ui_nav_wrap = true }
      end)
    end,
  },
}
