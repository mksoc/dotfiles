" Settings
set number
set tabstop=4
set shiftwidth=4
set scrolloff=5
set expandtab
set shell=zsh
set splitright
set splitbelow
set incsearch
set hidden
set ttimeout
set ttimeoutlen=0
set noswapfile
autocmd FileType * set formatoptions-=cro

" Mappings
let mapleader=" "

nnoremap U <C-r>

nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

nnoremap <leader>w <C-w>

nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

nnoremap <leader>fe :E<CR>
autocmd FileType netrw nnoremap <buffer> <ESC> :Rexplore<CR>
nnoremap <leader>gg :lcd %:p:h \| :tab terminal ++close lazygit<CR>

" Custom commands
command! W w
command! Wq wq
command! Wqa wqa
command! Q q
command! Qa qa
" Plugins
call plug#begin()

    " List your plugins here
    Plug 'romainl/vim-cool'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'wsdjeg/vim-fetch'

call plug#end()

" Theme
if &diff
    colorscheme apprentice
endif
