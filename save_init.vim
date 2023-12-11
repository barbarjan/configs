"JW nvim conf

"------------------------nvim settings----------------------------------
:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set encoding=UTF-8
:set clipboard+=unnamedplus
:set scrolloff=10
:set updatetime=250
:set list
:set listchars=tab:\ \ ┊ "indentation guides why they don't work in python?
:set textwidth=80
" :set nowrap

"------------------------plugins-----------------------
call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'skywind3000/vim-auto-popmenu'
"auto pop pup simple vim menu

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'https://github.com/preservim/nerdtree'
"file tree

"Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tomtom/tcomment_vim'
" gcc to comment

Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
" Plug 'https://github.com/ryanoasis/nerd-fonts'
" doesn't work when installed that way
Plug 'https://github.com/tc50cal/vim-terminal'
"Plug 'https://github.com/terryma/vim-multiple-cursors'
"ctrl N (doesnt work)
" Plug 'https://github.com/neoclide/coc.nvim'
"autcompletion fucking stupid shit not working 

Plug 'https://github.com/windwp/nvim-ts-autotag'
"Plug 'https://github.com/AndrewRadev/tagalong.vim'
"tagalong desnt work i think but autotag is briliant 

" Plug 'nvim-lua/plenary.nvim'
" Plug 'https://github.com/tanvirtin/vgit.nvim'
" doesnt work maybe lua config is required

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"git integration

Plug 'rhysd/conflict-marker.vim'
"git conflicts tool

Plug 'https://github.com/ryanoasis/vim-devicons'
"the docs say it should be loaded last

Plug 'nvim-lua/plenary.nvim'
"Plug 'https://github.com/BurntSushi/ripgrep'
"doesn't work
Plug 'nvim-telescope/telescope.nvim'

" Plug 'dense-analysis/ale'
"code helpers or whatever organizer coc alternative

" Plug 'https://github.com/linux-cultist/venv-selector.nvim'
" doesn't work

" Plug 'jmcantrell/vim-virtualenv'
" doesn't work

Plug 'davidhalter/jedi-vim'
"python autocompletion without language server bullshit

Plug 'skywind3000/vim-auto-popmenu'
"doesn't work

call plug#end()

"-------------------------plugin conf--------------------
" let g:ale_completion_enabled = 1
let g:apc_enable_ft = {'*':1}

let g:tagalong_verbose = 1

" source for dictionary, current or other loaded buffers, see ':help cpt'
set cpt=.,k,w,b

" don't select the first item.
set completeopt=menu,menuone,noselect

" suppress annoy messages.
set shortmess+=c

lua << EOF
require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}
EOF
"-------------------------folds-------------------------

" Remember folds when saving and quitting
" au BufWinLeave * mkview
" au BufWinEnter * silent loadview
" au BufWinEnter * loadview

" Use space to toggle folds

"-------------------------remaps-------------------------
nnoremap <Space> za


" nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-f> :NERDTreeFocus<CR>:NERDTreeRefreshRoot<CR>

"nnoremap <C-n> :NERDTree<CR> "calling NERDTree without opening

" nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-t> :NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>

nnoremap <C-Q> :Telescope find_files<CR>

" inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" Use <Tab> to confirm suggestions in CtrlP
inoremap <expr> <Tab> pumvisible() ? "\<C-Y>" : "\<Tab>"

" nnoremap <C-s> :vertical rightbelow G<CR> "idk why rightbelow doesn't work
nnoremap <C-s> :vertical rightbelow G<CR>

nnoremap <C--> :vertical resize -8<CR>
nnoremap <C-=> :vertical resize +8<CR>

" auto close tag
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

"-------------------------colors-------------------------
" :colorscheme challenger_deep
:colorscheme OceanicNext
let g:airline_theme='minimalist'

let g:airline_powerline_fonts = 0

if !exists('g:airline_symbols') "without this if it looks broken
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.colnr = 'col '
let g:airline_symbols.linenr = '   line '
let g:tagalong_verbose = 1

"I would like to automate this
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=csscomplete#CompleteCSS
autocmd FileType vue set omnifunc=csscomplete#CompleteCSS

"-----------------------custom commands-----------------
:command W write
:command Wq wq
:command Q q
"I want this because sometimes when I save quickly i imput W instead of w
