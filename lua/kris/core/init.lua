vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.keymap.set("n", "<leader>ot", ":botright 10new | term<CR>")
vim.keymap.set("n", "%%", [[:<C-u>execute 'edit ' . input('File name: ')<CR>]])
vim.cmd('set number')
vim.cmd('set relativenumber')
