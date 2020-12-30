syntax on

set expandtab
set incsearch
set laststatus=2
set noerrorbells
set noswapfile
set nowrap
set relativenumber
set rnu
set shiftwidth=4
set smartcase
set smartindent
set splitright
set tabstop=4 softtabstop=4
set undodir=~/.vim/undodir
set undofile
set wildmenu

"CoC settings
set cmdheight=2
set colorcolumn=80
set hidden
set nobackup
set nowritebackup
set shortmess+=c
set updatetime=50
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'theprimeagen/vim-be-good'
Plug 'vim-utils/vim-man'
Plug 'wakatime/vim-wakatime'

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derivce_root='true'
endif

"general styling
let g:mkdp_browser = 'Google Chrome'
let g:prettier#autoformat_require_pragma = 0
let loaded_matchparen = 1
let mapleader = " "
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:ctrlp_use_caching = 0

"fzf search features
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

"CoC documentation show
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

"terminal toggle keys
nnoremap <leader>z :call Term_toggle(10)<cr>
tnoremap <leader>zt <C-\><C-n>:call Term_toggle(10)<cr>

"general window movement/navigation
"set macro for *cgn"changewords"<esc>. x amount of times to change
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>v :wincmd v<CR>
nnoremap <leader>q :wincmd q<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>u :UndoTreeShow<CR>
nnoremap <silent><leader>3 :res +5<CR>
nnoremap <silent><leader>4 :res -5<CR>
nnoremap <silent><leader>1 :vertical resize +5<CR>
nnoremap <silent><leader>2 :vertical resize -5<CR>

"CoC
"autocomplete
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"tab remap
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"definition navigation
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

"react refactor
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"default fzf start location
nnoremap <leader>f :FZF~/Desktop/codebases<cr>

"markdownremaps
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle
