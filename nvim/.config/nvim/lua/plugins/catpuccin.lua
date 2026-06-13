return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('catppuccin').setup {
      custom_highlights = function(colors)
        return {
          -- Make `Gitsigns toggle_linehl` / `toggle_deleted` read like a small diff.
          GitSignsAddLn = { bg = '#24382f' },
          GitSignsChangeLn = { bg = '#27324a' },
          GitSignsDeleteLn = { bg = '#3f2631' },
          GitSignsChangedeleteLn = { bg = '#3f2631' },
          GitSignsTopdeleteLn = { bg = '#3f2631' },
          GitSignsDeleteVirtLn = { fg = colors.red, bg = '#3f2631' },
          GitSignsDeleteVirtLnInLine = { bg = '#6b2d3b' },
          GitSignsVirtLnum = { fg = colors.overlay1, bg = '#3f2631' },

          -- fff
          FffGitModified = { fg = colors.yellow },
          FffGitStaged = { fg = colors.green },
          FffGitUntracked = { fg = colors.blue },
          FffGitDeleted = { fg = colors.red },
          FffGitRenamed = { fg = colors.mauve },
          FffGitIgnored = { fg = colors.overlay0 },

          -- Search
          IncSearch = { bg = '#FFF000', fg = '#1E1E2E' }, -- yellow bg, dark fg
          Search = { bg = '#E6D800', fg = '#1E1E2E' }, -- slightly dimmer yellow
          CurSearch = { bg = '#FFD700', fg = '#1E1E2E', bold = true }, -- gold, bold
        }
      end,
      integrations = {
        blink_cmp = true,
        cmp = false,
        gitsigns = true,
        treesitter = true,
        neo_tree = false,
        harpoon = true,
        mini = false,
      },
    }
    -- Load the colorscheme here
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
