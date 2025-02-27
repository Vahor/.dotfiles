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
          min_width = 40,
          max_height = 15,
          -- winblend = 6,
          border = 'rounded',
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'source_name' },
            },
          },
        },
        documentation = {
          auto_show = true,
          treesitter_highlighting = true,
          window = {
            min_width = 10,
            max_width = 100,
            max_height = 20,
            border = 'rounded',
            -- winblend = 6,
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
