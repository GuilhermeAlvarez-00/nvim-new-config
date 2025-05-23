return {
	{
		'nvim-telescope/telescope.nvim',
		cmd = "Telescope",
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [A]ll files' })
			vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = '[S]earch by [G]rep' })
			vim.keymap.set('n', '<leader>b', builtin.buffers)
			vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find)
		end
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup {
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown {}
					}
				}
			}
			require("telescope").load_extension("ui-select")
		end
	}
}
