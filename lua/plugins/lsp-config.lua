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

			lspconfig.tailwindcss.setup({})

			lspconfig.lua_ls.setup({
				capabilities = capabilities
			})

			lspconfig.ts_ls.setup({
				handlers = {
					["textDocument/publishDiagnostics"] = function(
							_,
							result,
							ctx,
							config
					)
						if result.diagnostics == nil then
							return
						end

						-- ignore some tsserver diagnostics
						local idx = 1
						while idx <= #result.diagnostics do
							local entry = result.diagnostics[idx]

							-- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
							if entry.code == 80001 then
								-- { message = "File is a CommonJS module; it may be converted to an ES module.", }
								table.remove(result.diagnostics, idx)
							else
								idx = idx + 1
							end
						end

						vim.lsp.diagnostic.on_publish_diagnostics(
							_,
							result,
							ctx,
							config
						)
					end,
				},
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

			lspconfig.emmet_language_server.setup({})
		end
	}
}
