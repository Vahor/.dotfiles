return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'markdown_inline', 'vim', 'vimdoc', 'java', 'go' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
      }

      -- Add d2 (https://github.com/ravsii/tree-sitter-d2)
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.d2 = {
        install_info = {
          url = 'https://github.com/ravsii/tree-sitter-d2',
          files = { 'src/parser.c' },
          branch = 'main',
        },
        filetype = 'd2',
      }

      -- we also need to tell neovim to use "d2" filetype on "*.d2" files, as well as
      -- token comment.
      -- ftplugin/autocmd is also an option.
      vim.filetype.add {
        extension = {
          d2 = function()
            return 'd2', function(bufnr)
              vim.bo[bufnr].commentstring = '# %s'
            end
          end,
        },
      }
      -- Note: once installed, clone git repo's query folder into ~/.local/share/nvim/lazy/nvim-treesitter/queries/d2
    end,
  },
}
