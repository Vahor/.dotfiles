return {
  { -- Autoformat
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        notify_on_error = true,
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'ruff', 'black', stop_after_first = true },
          javascript = { 'biome' },
          json = { 'biome' },
          jsonc = { 'biome' },
          css = { 'biome' },
          d2 = { 'd2' },
          java = { 'google-java-format' },
        },
      }

      vim.keymap.set({ 'n', 'v' }, '<leader>l', function()
        require('conform').format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
        print 'Formatted'
      end, { desc = 'Format file or selection' })
    end,
  },
}
