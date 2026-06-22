return {
  'dmtrKovalenko/fff.nvim',
  build = function()
    -- downloads a prebuilt binary or falls back to cargo build
    require('fff.download').download_or_build_binary()
  end,
  lazy = false,
  config = function()
    local fff = require 'fff'
    fff.setup {
      prompt = ' > ',
      debug = {
        enabled = false,
        show_scores = false,
      },
      layout = {
        show_scrollbar = false,
      },
      grep = {
        trim_whitespace = true,
      },
      git = {
        status_text_color = true,
      },
    }
    
		vim.keymap.set("n", "<leader>sr", fff.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set('n', '<leader>sf', fff.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', fff.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sn', function()
      fff.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
    -- vim.keymap.set('n', '<leader>sT', function()
    --   fff.live_grep { query = '(TODO|FIXME|BUG|FIXME|TODO|HACK|WIP):' }
    -- end, { desc = '[S]earch [T]odo' })
  end,
}
