local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- NORMAL
keymap.set('i', 'jj', '<ESC>', opts)
keymap.set('n', '<leader>i', '<CMD>Lspsaga goto_definition<CR>')
keymap.set('n', 'ff', 'F')
keymap.set('n', 'tm', '<CMD> Telescope colorscheme <CR>')
keymap.set('n', '<leader>sa', '<CMD>wa <CR>')
keymap.set('n', '<leader>e', '<CMD>Ex <CR>')

-- Replace content
keymap.set('n', 'R', ':%s/\\C')

-- Close current buffer (file)
keymap.set('n', '<Space>x', ':bd<CR>', opts)

-- Format
vim.keymap.set('n', '<C-s>', ':w<CR>')

