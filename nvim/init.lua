vim.g.mapleader = " "

-- lazy.nvim configuration
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Include extra configs
require("mappings")

-- Basic options
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.pumheight = 10
vim.cmd("colorscheme kanagawa-wave")
vim.opt.shell = "zsh"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

-- Disable comment continuation on new line
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

-- Set filetype for SystemRDL
local group = vim.api.nvim_create_augroup('systemrdl_ft', { clear = true })

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.rdl',
    callback = function()
        vim.cmd('set syntax=systemrdl')
    end,
    group = group,
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.rdl',
    callback = function()
        vim.cmd('set filetype=systemrdl')
    end,
    group = group,
})

local ft = require("Comment.ft")
ft({"systemrdl"}, ft.get("c"))
