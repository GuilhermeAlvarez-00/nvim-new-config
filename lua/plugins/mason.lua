return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",       -- LSP source for nvim-cmp
		"hrsh7th/cmp-buffer",         -- Buffer source for nvim-cmp
		"hrsh7th/cmp-path",           -- Path completion
		"hrsh7th/cmp-cmdline",        -- Command line completion
		"saadparwaiz1/cmp_luasnip",   -- Snippet completion source
		"L3MON4D3/LuaSnip",           -- Snippet engine
		"rafamadriz/friendly-snippets", -- Snippet collection
		"onsails/lspkind.nvim",       -- For icons in completion menu
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ 'j-hui/fidget.nvim', opts = {} },
		{ 'folke/neodev.nvim', opts = {} },

	},
	config = function()
		-- Mason setup
		require('mason').setup()

		-- start LSP config
		require('plugins.LSP.lspkind')
		require('plugins.LSP.cmp')
		require('plugins.LSP.mason')

		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
			callback = function(event)
				-- NOTE: Remember that lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself
				-- many times.
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})
	end
}
