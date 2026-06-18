return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				variant = "dark",
				override_by_extension = {
					proto = {
						icon = "",
						color = "#81e043",
						name = "Log",
					},
				},
			})
		end,
	},
}
