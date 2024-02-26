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
require("mappings")

vim.cmd("colorscheme kanagawa-wave")
vim.opt.shell = "zsh"
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"
