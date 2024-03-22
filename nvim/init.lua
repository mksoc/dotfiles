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
vim.cmd.colorscheme("kanagawa-wave")
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.pumheight = 10
vim.opt.scrolloff = 10
vim.opt.shell = "zsh"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"
vim.opt.shortmess:append({ I = true })
vim.opt.updatetime = 500

-- Python3 executable
-- local pythonPath = vim.fn.system('which python3')
-- pythonPath = pythonPath:gsub("%s+", "")
-- vim.g.python3_host_prog = pythonPath

-- Highlight word under cursor with LSP
local function highlight_symbol(event)
    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil or not client.supports_method('textDocument/documentHighlight') then
        return
    end

    local group = vim.api.nvim_create_augroup('highlight_symbol', { clear = false })

    vim.api.nvim_clear_autocmds({ buffer = event.buf, group = group })

    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = group,
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = group,
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
    })
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Setup highlight symbol',
    callback = highlight_symbol,
})

-- Disable comment continuation on new line
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

-- Set filetype for SystemRDL
local group = vim.api.nvim_create_augroup('systemrdl_ft', { clear = true })

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.rdl',
    callback = function()
        vim.cmd('set syntax=systemrdl')
    end,
    group = group,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.rdl',
    callback = function()
        vim.cmd('set filetype=systemrdl')
    end,
    group = group,
})

local ft = require("Comment.ft")
ft({ "systemrdl" }, ft.get("c"))

-- Set filetype for Jinja
-- vim.filetype.add {
--     extension = {
--         jinja = 'jinja',
--         jinja2 = 'jinja',
--         j2 = 'jinja',
--     },
-- }
