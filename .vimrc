if !has("compatible")
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
let g:syntastic_rst_checkers = ['sphinx']
let g:syntastic_rst_sphinx_quiet_messages = { "level": "warning" }
let g:syntastic_aggregate_errors = 1

Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-repeat'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'hdima/python-syntax'
Plugin 'tmhedberg/SimpylFold'

Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'

Plugin 'davidhalter/jedi-vim'
let g:jedi#show_call_signatures = "0"

Plugin 'janko-m/vim-test'
Plugin 'christoomey/vim-tmux-navigator'
let test#strategy = "dispatch"

Plugin 'vim-scripts/DirDiff.vim'
Plugin 'sukima/xmledit'

Plugin 'Rykka/riv.vim'
let g:riv_fold_level = 2

Plugin 'lervag/vimtex'

call vundle#end()

filetype plugin indent on
filetype plugin on

augroup Filetypes
    autocmd BufNewFile,BufRead inttrc* set filetype=inttrc
    autocmd BufNewFile,BufRead ipstrc*.drw set filetype=ipstrc_drw
    autocmd BufNewFile,BufRead ipstrc*.dmp set filetype=ipstrc_dmp
augroup END

syntax enable
let python_highlight_all = 1

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


let mapleader=","

nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>ts :TestSuite<cr>
nnoremap <silent> <leader>tl :TestLast<cr>

nnoremap <leader>w :vertical resize 84<cr>


set background=dark

set nomodeline
set tabstop=4
set shiftwidth=4
set shiftround
set smarttab
set expandtab
set autoindent
set copyindent

" Overwritten in an autocmd
set nonumber
set norelativenumber

set showmatch
set hlsearch
set incsearch
set scrolloff=999

set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells
set winwidth=86
set winminwidth=40

set autochdir

set list
set listchars=
autocmd filetype py set listchars+=tab:>.

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

noremap <silent> <leader>\ :nohlsearch<CR>:Windo ccl<bar>lcl<CR>

" Like windo but restore the current window.
function! WinDo(command)
    let currwin=winnr()
    execute 'windo ' . a:command
    execute currwin . 'wincmd w'
endfunction
com! -nargs=+ -complete=command Windo call WinDo(<q-args>)

" Remove trailing whitespace
noremap dt :s/\v\s+$//<CR>:nohlsearch<CR>

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
endif "Ignore all commands if using vi
