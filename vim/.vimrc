" Settings
set tabstop=4
set shiftwidth=4
set scrolloff=5
set expandtab
set shell=zsh
set splitright
set splitbelow
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'

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

nnoremap <silent> <ESC> :noh<CR>

nnoremap <leader>gg :lcd %:p:h \| :tab terminal ++close lazygit<CR>

" Plugins
call plug#begin()

    " List your plugins here
    Plug 'francoiscabrol/ranger.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

call plug#end()
