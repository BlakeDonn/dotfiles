
syntax on

set splitright
set nowrap

"neoclide (autocomplete) settings
set updatetime=50
set hidden
set nobackup
set nowritebackup
set cmdheight=2

set wildmenu
set laststatus=2
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set smartcase
set noswapfile
set undodir=~/.vim/undodir
set undofile
set incsearch

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'jremmen/vim-ripgrep'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derivce_root='true'
endif

let g:prettier#autoformat_require_pragma = 0
let loaded_matchparen = 1
let mapleader = " "
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:ctrlp_use_caching = 0

let g:fxf_layout = { 'window': { 'width': 0.8, 'height':0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:term_buf = 0
let g:term_win = 0

"toggle terminal function
function! Term_toggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

"autocomplete function for neoclide
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


nnoremap <leader>z :call Term_toggle(10)<cr>
tnoremap <leader>zt <C-\><C-n>:call Term_toggle(10)<cr>

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

"autocomplete for neoclide
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nnoremap <silent><leader>3 :res +5<CR>
nnoremap <silent><leader>4 :res -5<CR>
nnoremap <silent><leader>1 :vertical resize +5<CR>
nnoremap <silent><leader>2 :vertical resize -5<CR>

nnoremap <leader>f :FZF~ <cr>

