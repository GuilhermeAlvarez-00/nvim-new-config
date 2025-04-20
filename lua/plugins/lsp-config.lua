return {
	-- MASON
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})
		end
	},
	-- MASON-LSPCONFIG
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls" },
			})
		end
	},
	-- LSPCONFIG
	{
		"nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			local lspconfig = require('lspconfig')

			local util = require("lspconfig.util");

			lspconfig.lua_ls.setup({
				capabilities = capabilities
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,

				-- Limit of ram to use in ts_ls
				cmd = {
					"typescript-language-server",
					"--stdio"
				},
				init_options = {
					maxTsServerMemory = 4096, -- 4GB for tsserver
				},

				root_dir = util.root_pattern("tsconfig.json", "package.json", ".git"),

				on_init = function(client)
					-- Only use one encoding to avoid bugs/perf issues
					client.offset_encoding = 'utf-16'
				end,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = false,
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = false,
							includeInlayVariableTypeHints = false,
							includeInlayPropertyDeclarationTypeHints = false,
							includeInlayFunctionLikeReturnTypeHints = false,
							includeInlayEnumMemberValueHints = false,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = false,
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = false,
							includeInlayVariableTypeHints = false,
							includeInlayPropertyDeclarationTypeHints = false,
							includeInlayFunctionLikeReturnTypeHints = false,
							includeInlayEnumMemberValueHints = false,
						},
					},
					completions = {
						completeFunctionCalls = false,
					}
				}
			})
		end
	}
}
