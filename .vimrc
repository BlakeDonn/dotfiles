syntax on

let g:polyglot_disabled = ['markdown']
set incsearch "incrementeal searching (highlights as you search)"
set laststatus=2
set noerrorbells "no ringy bois"
set noswapfile 
set nowrap  "doesnt wrap lines"
set number relativenumber "numbers are displayed relative to what line you are on"
set scrolloff=8 "scrolls when you get 8 lines from top or bottom"
set nu rnu
set nohlsearch
set shiftwidth=2
set smartcase
set splitright
set tabstop=2 softtabstop=2
set expandtab
set smartindent
set guicursor=
set undodir=~/.vim/undodir
set undofile
set wildmenu

"Folding
set foldmethod=indent

"CoC settings
set cmdheight=2
set colorcolumn=80
set signcolumn=yes  "shows linter errors in column to the left"
set hidden
set nobackup
set nowritebackup
set shortmess+=c
set updatetime=100
highlight ColorColumn ctermbg=0 guibg=lightgrey
highlight Normal guibg=none

call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html' ] }
Plug 'sheerun/vim-polyglot'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'ayu-theme/ayu-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'theprimeagen/vim-be-good'
Plug 'vim-utils/vim-man'
Plug 'wakatime/vim-wakatime'

call plug#end()

colorscheme ayu
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

"global variable replace
nnoremap gR gD:%s///gc<left><left><left>

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

augroup ReactFiletypes
  autocmd!
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
augroup END

"react refactor
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"default fzf start location
nnoremap <leader>f :FZF~<cr>

"markdownremaps
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle


"lighthouse
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

""""""""""""
function! s:center(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction
"let s:header= [
"      \"  ⢀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⣠⣤⣶⣶ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⢰⣿⣿⣿⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣀⣀⣾⣿⣿⣿⣿ ",
"      \"  ⣿⣿⣿⣿⣿⡏⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⠀⠀⠀⠈⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠁⠀⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠙⠿⠿⠿⠻⠿⠿⠟⠿⠛⠉⠀⠀⠀⠀⠀⣸⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣴⣿⣿⣿⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⢰⣹⡆⠀⠀⠀⠀⠀⠀⣭⣷⠀⠀⠀⠸⣿⣿⣿⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠈⠉⠀⠀⠤⠄⠀⠀⠀⠉⠁⠀⠀⠀⠀⢿⣿⣿⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣿⣿⢾⣿⣷⠀⠀⠀⠀⡠⠤⢄⠀  ⠠⣿⣿⣷⠀⢸⣿⣿⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣿⣿⡀⠉⠀⠀⠀⠀⠀⢄⠀⢀⠀⠀⠀⠀⠉⠉⠁⠀⠀⣿⣿⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿ ",
"      \"  ⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿ ",
"      \]


"let s:header= [
"      \"                          oooo$$$$$$$$$$$$oooo                               ",
"      \"                       oo$$$$$$$$$$$$$$$$$$$$$$$$o                           ",
"      \"                    oo$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$o         o$   $$ o$     ",
"      \"    o $ oo        o$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$o       $$ $$ $$o$    ",
"      \" oo $ $  $      o$$$$$$$$$    $$$$$$$$$$$$$    $$$$$$$$$o       $$$o$$o$     ",
"      \"  $$$$$$o$     o$$$$$$$$$      $$$$$$$$$$$      $$$$$$$$$$o    $$$$$$$$      ",
"      \"   $$$$$$$    $$$$$$$$$$$      $$$$$$$$$$$      $$$$$$$$$$$$$$$$$$$$$$$      ",
"      \"   $$$$$$$$$$$$$$$$$$$$$$$    $$$$$$$$$$$$$    $$$$$$$$$$$$$$     $$$        ",
"      \"     $$$    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$      $$$       ",
"      \"     $$$   o$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$      $$$o     ",
"      \"    o$$    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$       $$$o    ",
"      \"    $$$    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$   $$$$$$ooooo$$$$o  ",
"      \"   o$$$oooo$$$$$  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$   o$$$$$$$$$$$$$$$$$ ",
"      \"   $$$$$$$$$$$$$   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$     $$$$               ",
"      \"             $$$$      $$$$$$$$$$$$$$$$$$$$$$$$$$$$      o$$$               ",
"      \"             $$$o         $$$$$$$$$$$$$$$$$$$$$          $$$                 ",
"      \"               $$$o          $$$$$$$$$$$$$$$           $$$                  ",
"      \"                $$$$o                                o$$$                    ",
"      \"                 $$$$$o      o$$$$$$o$$$$$o        $$$$                      ",
"      \"                   $$$$$oo     $$$$o$$$$$o    $$$$$$                         ",
"      \"                      $$$$$$$oooo  $$$$o$$$$$$$$$$$                          ",
"      \"                         $$$$$$$$$oo $$$$$$$$$$                              ",
"      \"                                 $$$$$$$$$$$$$$$                             ",
"      \"                                     $$$$$$$$$$$$                            ",
"      \"                                      $$$$$$$$$$                             ",
"      \"                                       $$$$$$$                               ",
"      \] 

"let s:header=[
"      \"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
"      \"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
"      \"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
"      \"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
"      \"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
"      \"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
"      \]
                                                  

let s:header= [
      \"                                                    oooo$$$$$$$$$$$$oooo                               ",
      \"                                                 oo$$$$$$$$$$$$$$$$$$$$$$$$o                           ",
      \"                                              oo$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$o         o$   $$ o$     ",
      \"                              o $ oo        o$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$o       $$ $$ $$o$    ",
      \"                           oo $ $  $      o$$$$$$$$$    $$$$$$$$$$$$$    $$$$$$$$$o       $$$o$$o$     ",
      \"                            $$$$$$o$     o$$$$$$$$$      $$$$$$$$$$$      $$$$$$$$$$o    $$$$$$$$      ",
      \"                             $$$$$$$    $$$$$$$$$$$      $$$$$$$$$$$      $$$$$$$$$$$$$$$$$$$$$$$      ",
      \"                             $$$$$$$$$$$$$$$$$$$$$$$    $$$$$$$$$$$$$    $$$$$$$$$$$$$$     $$$        ",
      \"                               $$$    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$      $$$       ",
      \"                               $$$   o$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$      $$$o     ",
      \"                              o$$    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$       $$$o    ",
      \"                              $$$    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$   $$$$$$ooooo$$$$o  ",
      \"                             o$$$oooo$$$$$  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$   o$$$$$$$$$$$$$$$$$ ",
      \"                             $$$$$$$$$$$$$   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$     $$$$               ",
      \"                                       $$$$      $$$$$$$$$$$$$$$$$$$$$$$$$$$$      o$$$               ",
      \"                                       $$$o         $$$$$$$$$$$$$$$$$$$$$          $$$                 ",
      \"                                         $$$o          $$$$$$$$$$$$$$$           $$$                  ",
      \"                                          $$$$o                                o$$$                    ",
      \"                                           $$$$$o      o$$$$$$o$$$$$o        $$$$                      ",
      \"    ██████╗  ██████╗ ███╗   ██╗████████╗    $$$$$oo     $$$$o$$$$$o    $$$$$$     ██████╗  █████╗ ███╗   ██╗██╗ ██████╗                    ",
      \"    ██╔══██╗██╔═══██╗████╗  ██║╚══██╔══╝     $$$$$$$oooo  $$$$o$$$$$$$$$$$        ██╔══██╗██╔══██╗████╗  ██║██║██╔════╝                  ",
      \"    ██║  ██║██║   ██║██╔██╗ ██║   ██║           $$$$$$$$$oo $$$$$$$$$$            ██████╔╝███████║██╔██╗ ██║██║██║                       ",
      \"    ██║  ██║██║   ██║██║╚██╗██║   ██║                   $$$$$$$$$$$$$$$           ██╔═══╝ ██╔══██║██║╚██╗██║██║██║                       ",
      \"    ██████╔╝╚██████╔╝██║ ╚████║   ██║                       $$$$$$$$$$$$          ██║     ██║  ██║██║ ╚████║██║╚██████╗                  ",
      \"    ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝                        $$$$$$$$$$           ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝                  ",
      \"                                                                 $$$$$$$                               ",
      \]                           
                                                                             
 
    
    
    
    
    
    
                                                                             



let g:startify_enable_special      = 0
let g:startify_lists = [{'type': 'commands'}]
let g:startify_custom_header = s:center(s:header)
highlight StartifyHeader  ctermfg=22
