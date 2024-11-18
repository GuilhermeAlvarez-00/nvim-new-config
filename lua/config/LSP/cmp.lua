local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),  -- Adds border to the completion menu
		documentation = cmp.config.window.bordered(), -- Adds border to the documentation window
	},
	mapping = cmp.mapping.preset.insert({
		['<C-v>'] = cmp.mapping({
			i = cmp.mapping.complete(), -- open IntelliSense with Ctrl+e in insert mode
		}),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	}),
	completion = {
		autocomplete = { require('cmp.types').cmp.TriggerEvent.InsertEnter, require('cmp.types').cmp.TriggerEvent.TextChanged },
		completeopt = 'menu,menuone,noinsert',
	},
	performance = {
		debounce = 60, -- Adjust debounce time (in milliseconds)
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text',
			maxwidth = 90,
			ellipsis_char = '...',
		}),
	},
})


-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
