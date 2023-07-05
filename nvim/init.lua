vim.opt.number = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.api.nvim_command([[
autocmd UIEnter * if v:event.chan ==# 0 | call chansend(v:stderr, "") | endif
autocmd UILeave * if v:event.chan ==# 0 | call chansend(v:stderr, "") | endif
]])
