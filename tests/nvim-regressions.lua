-- Run from the repository root:
-- nvim --headless -u NONE -l tests/nvim-regressions.lua
local root = vim.fn.getcwd() .. '/nvim/.config/nvim/'

-- Markdown should use the same configured completion sources as other buffers.
local blink = dofile(root .. 'lua/plugins/blink.lua')[2].opts
assert(blink.sources.per_filetype == nil or blink.sources.per_filetype.markdown == nil)
assert(vim.deep_equal(blink.sources.default, { 'lsp', 'buffer' }))

-- Simulate a parser finishing installation after focus changed to another buffer.
local callback, finished
package.preload['nvim-treesitter.config'] = function()
  return { norm_languages = function() return {} end }
end
package.preload['nvim-treesitter'] = function()
  return {
    get_available = function() return { 'lua' } end,
    get_installed = function() return {} end,
    install = function()
      return { await = function(_, fn) finished = fn end }
    end,
  }
end
local original_autocmd = vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd = function(_, opts) callback = opts.callback end
vim.treesitter.language.get_lang = function() return 'lua' end
vim.treesitter.language.add = function() return true end
vim.treesitter.query.get = function() return {} end
local started
vim.treesitter.start = function(buf) started = buf end

dofile(root .. 'lua/plugins/treesitter.lua')[1].config()
vim.api.nvim_create_autocmd = original_autocmd
local target = vim.api.nvim_create_buf(false, true)
local other = vim.api.nvim_create_buf(false, true)
vim.api.nvim_set_current_buf(other)
vim.bo[target].indentexpr = ''
vim.bo[other].indentexpr = ''
callback { buf = target, match = 'lua' }
assert(finished, 'parser installation callback was not registered')
finished()
assert(started == target, 'highlighting must attach to the original buffer')
assert(vim.bo[target].indentexpr ~= '', 'original buffer must get indentation')
assert(vim.bo[other].indentexpr == '', 'current unrelated buffer must be unchanged')

-- Closing the original buffer while installation runs must remain safe.
vim.api.nvim_buf_delete(target, { force = true })
started = nil
finished()
assert(started == nil, 'deleted buffer must not receive highlighting')
print('Neovim configuration regression tests passed')
