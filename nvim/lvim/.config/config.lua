reload "user.plugins"
reload "user.options"
reload "user.keymaps"


-- Treesitter
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.context_commentstring.enable = true

lvim.builtin.treesitter.ensure_installed = {
  "python",
  "tsx",
  "typescript",
  "javascript",
  "go",
  "rust",
  "lua",
  "toml"
}


-- Telescope
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "frecency")
  pcall(telescope.load_extension, "neoclip")
  -- any other extensions loading
end

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }


-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Switch Env",
  p = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Python" },
}

-- debug adapter
lvim.builtin.dap.active = true

-- vim options

-- formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "ruff" } }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "ruff", filetypes = { "python" } } }


