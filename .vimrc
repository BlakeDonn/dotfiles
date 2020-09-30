syntax on

set updatetime=50
set hidden
set cmdheight=2
set wildmenu
set laststatus=2
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'vim-utils/vim-man'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'mbbill/undotree'
Plug 'jremmen/vim-ripgrep'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'prettier/vim-prettier', { 'do': 'yarn install','for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] } 

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derivce_root='true'
endif

let loaded_matchparen = 1
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc -exclude-standard']
let mapleader = " "
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:ctrlp_use_caching = 0

let g:fxf_layout = { 'window': { 'width': 0.8, 'height':0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

autocmd FileType javascript set formatprg=prettier\ --stdin
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>f :CtrlP /Users/bdizzle/Desktop/codebases<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>u :UndoTreeShow<CR>
nnoremap <leader>v :wincmd v<CR>
nnoremap <leader>q :wincmd q<CR>

nnoremap <silent><leader>+ :vertical resize +5<CR>
nnoremap <silent><leader>- :vertical resize -5<CR>

nnoremap <leader>f :FZF~ <cr>
nnoremap <leader>gd :ycmcompleter goto<cr>
nnoremap <leader>gd :ycmcompleter goto<cr>
nnoremap <leader>gf :YcmCompleter FixIt<CR>
oremap <leader>gf :YcmCompleter FixIt<CR>
