return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires special font.
    --  If you already have a Nerd Font, or terminal set up with fallback fonts
    --  you can enable this
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of help_tags options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    local actions = require 'telescope.actions'
    local trouble_telescope = require 'trouble.sources.telescope'
    local devicons = require 'nvim-web-devicons'

    -- region: resume_or_start
    local builtin = require 'telescope.builtin'
    local state = require 'telescope.state'

    -- Parameters:
    --   @param picker_name (string): A unique identifier for this picker type.
    --                                This should be a human-readable name that describes
    --                                what the picker does (e.g., 'Find Files', 'Live Grep').
    --                                This name is matched against the prompt_title of cached
    --                                pickers to determine if a resume is possible.
    --
    --                                IMPORTANT: This should match either:
    --                                1. The default prompt_title that Telescope uses for this picker
    --                                2. The prompt_title you explicitly set in opts
    --
    --   @param picker_func (function): The actual Telescope builtin function to call
    --                                  when starting a fresh picker (e.g., builtin.find_files,
    --                                  builtin.live_grep). This is only called if no cached
    --                                  version is found.
    --
    --   @param opts (table|nil): Optional configuration table to pass to the picker function.
    --                            This can include any valid Telescope option like:
    --                            - prompt_title: Custom title for the picker window
    --                            - cwd: Directory to search in
    --                            - grep_open_files: Search only in open files
    --                            - theme options, preview settings, etc.
    --
    --                            If prompt_title is set in opts, it takes precedence
    --                            over picker_name for matching cached pickers.
    local function resume_or_start(picker_name, picker_func, opts)
      return function()
        opts = opts or {}

        -- Try to find a cached picker with the same name
        local cached_pickers = state.get_global_key 'cached_pickers' or {}
        local picker_index = nil

        -- Search through cached pickers to find matching one
        for i, cached_picker in ipairs(cached_pickers) do
          if cached_picker.prompt_title == (opts.prompt_title or picker_name) then
            picker_index = i
            break
          end
        end

        if picker_index then
          -- Resume the specific cached picker
          builtin.resume { cache_index = picker_index }
        else
          -- Start fresh picker
          picker_func(opts)
        end
      end
    end

    -- endregion

    local function filenameFirst(_, path)
      local tail = vim.fs.basename(path)
      local parent = vim.fs.dirname(path)
      if parent == '.' then
        return tail
      end
      return string.format('%s\t\t%s', tail, parent)
    end

    local function limit_path_depth(path, max_segments)
      local parts = vim.split(path, '/')
      if #parts <= max_segments + 1 then
        return path
      end
      local tail = vim.list_slice(parts, #parts - max_segments, #parts)
      return table.concat(tail, '/')
    end

    local function get_icon_for_path(path)
      local ext = vim.fn.fnamemodify(path, ':e')
      local icon, hl = devicons.get_icon(path, ext, { default = true })
      return icon or '', hl or 'TelescopeResultsFileIcon'
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'TelescopeResults',
      callback = function(ctx)
        vim.api.nvim_buf_call(ctx.buf, function()
          vim.fn.matchadd('TelescopeParent', '\t\t.*$')
          vim.api.nvim_set_hl(0, 'TelescopeParent', { link = 'Comment' })
        end)
      end,
    })

    local make_entry = require 'telescope.make_entry'
    local entry_display = require 'telescope.pickers.entry_display'

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { 'node_modules', 'vendor', 'generated' },
        dynamic_preview_title = true,
        path_display = filenameFirst,
        -- https://github.com/nvim-telescope/telescope.nvim/issues/3202#issuecomment-3335081083
        cache_picker = {
          num_pickers = -1, -- Cache unlimited pickers
          limit_entries = 1000, -- Limit entries per picker (for memory)
          ignore_empty_prompt = true, -- Don't cache if prompt is empty
        },
        preview = {
          -- Skip preview for large files
          filesize_limit = 0.1, -- MB
        },
        mappings = {
          i = {
            ['<c-q>'] = trouble_telescope.add,
          },
          n = {
            ['<c-q>'] = trouble_telescope.add,
          },
        },
      },
      pickers = {
        find_files = {
          follow = true,
          hidden = true,
          find_command = {
            'rg',
            '--files',
            '--trim',
            '--color=never',
            '-g',
            '!.git',
          },
        },
        live_grep = {
          additional_args = function()
            return { '--hidden', '-g', '!.git' }
          end,
          entry_maker = function(line)
            local entry = make_entry.gen_from_vimgrep {}(line)

            local path = vim.fn.fnamemodify(entry.filename, ':.') -- relative path
            local relpath = limit_path_depth(path, 2)
            local icon, hl = get_icon_for_path(entry.filename)
            local text = entry.text

            local displayer = entry_display.create {
              separator = ' ',
              items = {
                { width = 2 }, -- icon slot
                { remaining = true }, -- path (gray)
                { remaining = true }, -- text
              },
            }

            entry.display = function()
              return displayer {
                { icon, hl },
                { relpath, 'Comment' }, -- This makes the path gray
                text,
              }
            end

            entry.ordinal = path .. ' ' .. text

            return entry
          end,
        },
        buffers = {
          mappings = {
            i = {
              ['<c-d>'] = actions.delete_buffer + actions.move_to_top,
            },
            n = {
              ['<c-d>'] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    -- vim.keymap.set('n', '<leader>sf', resume_or_start('Find Files', builtin.find_files), { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    -- vim.keymap.set('n', '<leader>sg', resume_or_start('Live Grep', builtin.live_grep), { desc = '[S]earch by [G]rep' })
    -- vim.keymap.set('n', '<leader>sd', resume_or_start('Diagnostics', builtin.diagnostics), { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>st', '<Cmd>TodoTelescope<CR>', { desc = '[S]earch [T]odo' })

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
