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
	},
	config = function()
		-- Mason setup
		require('mason').setup()

		-- start LSP config
		require('plugins.LSP.lspkind')
		require('plugins.LSP.cmp')
		require('plugins.LSP.mason')
	end
}
