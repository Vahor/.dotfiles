return {
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { { 'ruff', 'black' } },
        javascript = { { 'biome', 'prettierd', 'prettier' } },
        json = { { 'biome', 'prettierd', 'prettier' } },
      },
    },
  },
}
