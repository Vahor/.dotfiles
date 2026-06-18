return {
	{
		"nvim-tree/nvim-web-devicons",
		-- enabled = vim.g.have_nerd_font,
		config = function()
			require("nvim-web-devicons").setup({
				variant = "dark",
				override_by_extension = {
					proto = {
						icon = "",
						color = "#81e043",
						name = "Proto",
					},
				},
			})
		end,
	},
}
