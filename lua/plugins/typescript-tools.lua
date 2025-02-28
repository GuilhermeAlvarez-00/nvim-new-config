return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	config = function()
		require("typescript-tools").setup({
			settings = {
				tsserver_max_memory = 8192, -- Increases memory for large projects
				tsserver_format_options = { indentSize = 2, tabSize = 2 },
				tsserver_log_level = "off",
			},
		})
	end
}
