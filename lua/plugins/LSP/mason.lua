local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- Mason LSPConfig setup
local mason_lspconfig = require('mason-lspconfig')


local ensure_installed = { "lua_ls", "pyright", "ts_ls", "tailwindcss", "prismals" }
local ensure_installed_language = { "lua", "python", "typescript", "javascript" }

mason_lspconfig.setup({
	ensure_installed = ensure_installed, -- Add more servers if needed
	automatic_installation = true,
})

-- LSPConfig setup for all installed servers
local lspconfig = require('lspconfig')

vim.keymap.set("n", "<leader>fa", vim.lsp.buf.format, {})

mason_lspconfig.setup_handlers({
	-- Default handler (optional)
	function(server_name)
		lspconfig[server_name].setup({

			capabilities = capabilities,
			completion = {
				callSnippet = "Replace", -- Customize how snippets are applied
			},
			workspace = {
				maxPreload = 100,  -- Reduce the number of files preloaded to improve speed
				preloadFileSize = 100, -- Limit the size of files to preload
			},
		})
	end,

	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
				},
			},
		})

		require 'nvim-treesitter.configs'.setup {
			ensure_installed = ensure_installed_language, -- Install all maintained parsers
			sync_install = false,                      -- Install parsers synchronously (only applied to `ensure_installed`)
			ignore_install = {},                       -- List of parsers to ignore installing (for example, {"javascript"})
			auto_install = true,                       -- Automatically install missing parsers when entering buffer

			highlight = {
				enable = true,                         -- False will disable the whole extension
				additional_vim_regex_highlighting = false, -- Disable Vim's regex highlighting
			},
			indent = {
				enable = true, -- Enable Treesitter-based indentation
			},
			modules = {}, -- Required field, typically left empty unless using custom modules
		}
	end,

})
