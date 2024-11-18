return {
	'nvimdev/lspsaga.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter', -- optional
		'nvim-treesitter/playground',
		'nvim-tree/nvim-web-devicons',   -- optional
	},

	build = ':TSUpdate', -- Automatically run :TSUpdate after installing
	config = function()
		require('lspsaga').setup({
			ui = {
				border = 'rounded',
				code_action = "",
			},
			symbol_in_winbar = {
				enable = false,
			},

			diagnostic = {
				max_height = 0.6,
				max_width = 0.6
			},
		})
	end,
}
