return {
	{
		"stevearc/oil.nvim",
		opts = {
			watch_for_changes = true,
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<leader>y"] = {
					callback = function()
						local oil = require("oil")
						local entry = oil.get_cursor_entry()
						if entry then
							local dir = oil.get_current_dir()
							local path = dir .. entry.name
							vim.fn.setreg("+", path)
							vim.notify("Copied: " .. path)
						end
					end,
					desc = "Copy file path to system clipboard",
				},
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
