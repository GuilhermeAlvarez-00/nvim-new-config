return {
	'nvimdev/lspsaga.nvim',
	event = "LspAttach",
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
				show_code_action = true,
				show_layout = "float", -- float or normal window
				max_width = 0.6,
				max_height = 0.6,
				keys = {
					quit = "q",
					exec = "<CR>",
				},
			},
		})

		--vim.keymap.set('n', '<leader>sd', '<CMD>Lspsaga show_line_diagnostics<CR>')
		vim.keymap.set('n', '<leader>sd', function()
			vim.diagnostic.open_float(nil, { border = "rounded" })
		end, { desc = "Show line diagnostics" })
		vim.keymap.set('n', '<leader>K', '<CMD>Lspsaga peek_definition<CR>')
		vim.keymap.set('n', '<leader>hd', '<CMD>Lspsaga hover_doc <CR>')
		vim.keymap.set('n', '<leader>ca', '<CMD>Lspsaga code_action <CR>')
	end,
}
