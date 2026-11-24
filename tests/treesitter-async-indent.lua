-- Run from the repository root:
-- nvim --headless -u NONE -l tests/treesitter-async-indent.lua
local root = vim.fn.getcwd() .. '/nvim/.config/nvim/'

local filetype_callback, install_callback
package.preload['nvim-treesitter.config'] = function()
  return { norm_languages = function() end }
end
package.preload['nvim-treesitter'] = function()
  return {
    get_available = function() return { 'lua' } end,
    get_installed = function() return {} end,
    install = function()
      return { await = function(_, callback) install_callback = callback end }
    end,
  }
end

local create_autocmd = vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd = function(_, options) filetype_callback = options.callback end
vim.treesitter.language.get_lang = function() return 'lua' end
vim.treesitter.language.add = function() return true end
vim.treesitter.query.get = function() return {} end
vim.treesitter.start = function() end

dofile(root .. 'lua/plugins/treesitter.lua')[1].config()
vim.api.nvim_create_autocmd = create_autocmd

local target = vim.api.nvim_create_buf(false, true)
local current = vim.api.nvim_create_buf(false, true)
vim.api.nvim_set_current_buf(current)
vim.bo[target].indentexpr = ''
vim.bo[current].indentexpr = ''

filetype_callback { buf = target, match = 'lua' }
assert(install_callback, 'expected parser installation to be pending')
install_callback()

assert(vim.bo[target].indentexpr ~= '', 'indentexpr should be set on the target buffer')
assert(vim.bo[current].indentexpr == '', 'the unrelated current buffer should be unchanged')
print('Treesitter async indentation check passed')
