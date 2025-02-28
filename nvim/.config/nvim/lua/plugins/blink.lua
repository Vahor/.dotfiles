return {
  {
    'saghen/blink.cmp',
    version = '*',
    dependencies = {},

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = { 'lsp' },
      },

      signature = { enabled = true },

      completion = {
        keyword = {
          range = 'full',
        },
        trigger = {
          show_in_snippet = false,
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        ghost_text = {
          enabled = false,
        },
        menu = {
          enabled = true,
          min_width = 30,
          max_height = 15,
          -- winblend = 6,
          scrollbar = false,
          draw = {
            columns = {
              { 'label', 'kind', gap = 2 },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          treesitter_highlighting = true,
          window = {
            min_width = 10,
            max_width = 100,
            max_height = 20,
            border = 'none',
            -- winblend = 6,
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
