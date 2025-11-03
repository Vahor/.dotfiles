return {
  'marilari88/twoslash-queries.nvim',
  config = function()
    vim.lsp.config('ts_ls', {
      on_attach = function(client, bufnr)
        require('twoslash-queries').attach(client, bufnr)
      end,
    })
    -- Optional: configure the plugin
    require('twoslash-queries').setup {
      multi_line = true, -- print types in multi-line mode
      is_enabled = true, -- enable at startup
      highlight = 'Type', -- highlight group for virtual text
    }
  end,
}
