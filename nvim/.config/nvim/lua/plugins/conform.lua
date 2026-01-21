return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>l',
        function()
          require('conform').format { async = true, timeout_ms = 1000, lsp_fallback = 'fallback' }
          print 'Formatted'
        end,
        mode = '',
        desc = 'Format file or selection',
      },
    },
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
          typescript = { 'biome' },
          json = { 'biome' },
          jsonc = { 'biome' },
          css = { 'biome' },
          d2 = { 'd2' },
          java = { 'google-java-format' },
        },
      }
    end,
  },
}
