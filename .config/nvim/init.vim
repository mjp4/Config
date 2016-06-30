filetype off

set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.cache/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')       " Auto completion
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources.scala = ['buffer', 'tag']
let g:deoplete#tag#cache_limit_size = 40000000
set tags=tags;/

call dein#add('tpope/vim-unimpaired')       " Commands such as [<space> for new line
call dein#add('tpope/vim-fugitive')         " Git support.
call dein#add('tpope/vim-dispatch')         " Run background jobs.
call dein#add('tpope/vim-surround')         " For example surround with quotes, ...
call dein#add('tpope/vim-repeat')           " Allows . repeating for more functions
call dein#add('tpope/vim-abolish')          " Quickly convert cases
call dein#add('tpope/vim-commentary')       " Comment code using gc{movement}
call dein#add('radenling/vim-dispatch-neovim')  " Use neovim terminal with dispatch
call dein#add('christoomey/vim-tmux-navigator') " Support for seamless tmux window support.
call dein#add('vim-airline/vim-airline')    " Pretty status line
call dein#add('airblade/vim-gitgutter')     " Git changes in gutter

call dein#add('scrooloose/nerdcommenter')   " Better code commenting
call dein#add('derekwyatt/vim-scala')       " Support for scala.
let g:scala_scaladoc_indent = 1
"call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('junegunn/fzf', { 'build': './install', 'merged': 0 })
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#end()

"Plugin 'scrooloose/syntastic'
"let g:syntastic_rst_checkers = ['sphinx']
"let g:syntastic_rst_sphinx_quiet_messages = { "level": "warning" }
"let g:syntastic_aggregate_errors = 1
"
"Plugin 'hynek/vim-python-pep8-indent'
"Plugin 'hdima/python-syntax'
"Plugin 'tmhedberg/SimpylFold'
"Plugin 'ervandew/supertab'
"Plugin 'davidhalter/jedi-vim'
"let g:jedi#show_call_signatures = "0"
"Plugin 'janko-m/vim-test'
"let test#strategy = "dispatch"
"Plugin 'vim-scripts/DirDiff.vim'
"Plugin 'sukima/xmledit'
"Plugin 'Rykka/riv.vim'
"let g:riv_fold_level = 2
"Plugin 'lervag/vimtex'

"see :help airline | airline-customisations
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 119,
    \ 'x': 110,
    \ 'y': 128,
    \ 'z': 65,
    \ 'warning': 80,
    \ 'error': 80,
    \ }


filetype plugin on
filetype plugin indent on

augroup Filetypes
    autocmd BufNewFile,BufRead inttrc* set filetype=inttrc
    autocmd BufNewFile,BufRead ipstrc*.drw set filetype=ipstrc_drw
    autocmd BufNewFile,BufRead ipstrc*.dmp set filetype=ipstrc_dmp
augroup END

syntax enable
let python_highlight_all = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


let mapleader=","

nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>:e<cr>

nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>ts :TestSuite<cr>
nnoremap <silent> <leader>tl :TestLast<cr>

nnoremap <leader>w :vertical resize 84<cr>


set background=dark

set mouse=
set nomodeline
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set copyindent

" Overwritten in an autocmd
set nonumber
set norelativenumber

set showmatch
set scrolloff=999

set undolevels=1000
set title
set visualbell
set noerrorbells
set winwidth=86
set winminwidth=40

set autochdir
set wildignore+=*.swp,*.class,*target/*,*.vsd

set pastetoggle=<F2>

nnoremap <silent> <PageUp> <C-U>
nnoremap <silent> <PageDown> <C-D>
inoremap <silent> <PageUp> <C-O><C-U>
inoremap <silent> <PageDown> <C-O><C-D>
set nostartofline

vnoremap Q gq
nnoremap Q gqap

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
tnoremap <C-j> <C-n>
tnoremap <C-k> <C-p>

noremap <silent> <leader>\ :nohlsearch<CR>:Windo ccl<bar>lcl<CR>

noremap <C-P> :GitFiles<CR>
noremap <M-p> "ayiw:GitFiles<CR><c-\><c-n>"api

" Like windo but restore the current window.
function! WinDo(command)
    let currwin=winnr()
    execute 'windo ' . a:command
    execute currwin . 'wincmd w'
endfunction
com! -nargs=+ -complete=command Windo call WinDo(<q-args>)

" Remove trailing whitespace
noremap dt :%s/\v\s+$//<CR>:nohlsearch<CR>

cnoremap w!! w !sudo tee % >/dev/null

function! GetDocDir()
    " Returns the absolute path to a directory named docs in the directory
    " hierachy above the current file.
    let currpath = expand('%:p')
    while strlen(currpath) > 3
        let docpath = globpath(currpath, 'docs/')
        if docpath != ""
            return docpath
        endif
        let currpath = substitute(currpath, "/[^/]*$", "", "")
    endwhile
    return ""
endfunction

function! DocBuild()
    let docdir = GetDocDir()
    if docdir != ""
        silent! execute "Dispatch! sphinx-build -va " . docdir . " " . docdir . "build/html"
        silent! execute "Dispatch! sphinx-build -va " . docdir . "source/ " . docdir . "build/html"
    elseif &filetype == 'rst'
        call Rst2("html") | call Rst2("pdf")
    else
        make
    endif
endfunction

noremap <leader>db DocBuild()

augroup ActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal relativenumber
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal number
"    autocmd VimEnter,WinEnter,BufWinEnter * wincmd =
    autocmd WinLeave * setlocal nocursorline
    autocmd WinLeave * setlocal norelativenumber
    autocmd WinLeave * setlocal nonumber
augroup END

set t_Co=256
highlight CursorLine term=bold ctermbg=238 cterm=bold
highlight ColorColumn ctermbg=238
highlight PmenuSel ctermbg=white ctermfg=black
highlight Pmenu ctermbg=238 ctermfg=white
highlight jediFunction ctermbg=darkmagenta ctermfg=white
highlight jediFat ctermbg=darkmagenta ctermfg=white cterm=bold
highlight PreProc ctermfg=green
highlight LineNr ctermbg=238 ctermfg=250 cterm=bold
highlight Folded ctermbg=NONE cterm=bold
highlight CursorLineNr ctermbg=238 ctermfg=white cterm=NONE
highlight Special ctermfg=202
"highlight Search ctermfg=white

highlight StatusLine ctermbg=231 ctermfg=16
highlight StatusLineNC ctermbg=231 ctermfg=16
highlight VertSplit ctermbg=231 ctermfg=16
set fillchars=stl:-,stlnc:-,vert:\|,fold:-
