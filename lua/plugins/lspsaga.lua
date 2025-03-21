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
		})

		vim.keymap.set('n', '<leader>sd', '<CMD>Lspsaga show_line_diagnostics<CR>')
		vim.keymap.set('n', 'K', '<CMD>Lspsaga peek_definition<CR>')
		vim.keymap.set('n', '<leader>hd', '<CMD>Lspsaga hover_doc <CR>')
		vim.keymap.set('n', 'ca', '<CMD>Lspsaga code_action <CR>')
	end,
}
