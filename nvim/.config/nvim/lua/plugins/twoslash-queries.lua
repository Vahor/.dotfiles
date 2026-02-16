return {
  'marilari88/twoslash-queries.nvim',
  setup = {
    multi_line = true, -- print types in multi-line mode
    is_enabled = true, -- enable at startup
    highlight = 'Type', -- highlight group for virtual text
  },
  config = function()
    vim.lsp.config('tsgo', {
      on_attach = function(client, bufnr)
        require('twoslash-queries').attach(client, bufnr)
      end,
    })
  end,
}
