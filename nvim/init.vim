set path+=**

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set exrc
set relativenumber
set noerrorbells
set scrolloff=8
set incsearch
set noshowmode
set showcmd
set signcolumn=yes
set nu
set nowrap
set hidden
set nohlsearch

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

"setup vim-plug {{{

  "Note: install vim-plug if not present
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
  endif

  "Note: Skip initialization for vim-tiny or vim-small.
  if !1 | finish | endif
  if has('vim_starting')
    set nocompatible               " Be iMproved
    " Required:
    call plug#begin()
  endif

"}}}

call plug#begin('~/.vim/plugged')

" Theme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'mbbill/undotree'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'vuciv/vim-bujo'

" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'glepnir/lspsaga.nvim'

Plug 'sbdchd/neoformat'

call plug#end()

lua require("vahor")

" Apply theme
colorscheme tokyonight

let mapleader = " "

nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>

nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>pv :Vex<CR>


xnoremap <leader>p "_dP

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" delete instead of cut
nnoremap <leader>d "_d
vnoremap <leader>d "_d


nnoremap <leader>x :silent !chmod +x %<CR>

" Unmap arrow keys ! Learn the hard way
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" Netwr
let g:netrw_banner = 0
let g:netrw_winsize = 25


augroup VAHOR
    autocmd!
    " TODO : Ajouter des types de fichiers
    autocmd BufWritePre * Neoformat
    " md is markdown
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.md set spell
augroup END


