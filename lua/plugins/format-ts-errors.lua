return {
	"davidosomething/format-ts-errors.nvim",
	config = function()
		require("format-ts-errors").setup({
			add_markdown = false,      -- wrap output with markdown ```ts ``` markers
			start_indent_level = 1,   -- initial indent
		})
	end
}
