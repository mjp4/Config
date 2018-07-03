filetype off

set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.cache/dein'))

call dein#add('Shougo/dein.vim')

call dein#add('Shougo/deoplete.nvim')       " Auto completion
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources.scala = ['buffer', 'tag']
let g:deoplete#tag#cache_limit_size = 40000000
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
set tags=tags;/

call dein#add('tpope/vim-unimpaired')       " Commands such as [<space> for new line
call dein#add('tpope/vim-fugitive')         " Git support.
call dein#add('tpope/vim-dispatch')         " Run background jobs.
call dein#add('tpope/vim-surround')         " For example surround with quotes, ...
call dein#add('tpope/vim-repeat')           " Allows . repeating for more functions
call dein#add('tpope/vim-abolish')          " Quickly convert cases
call dein#add('tpope/vim-commentary')       " Comment code using gc{movement}
call dein#add('tpope/vim-sleuth')           " Automatically use correct indents
call dein#add('radenling/vim-dispatch-neovim')  " Use neovim terminal with dispatch
call dein#add('christoomey/vim-tmux-navigator') " Support for seamless tmux window support.
call dein#add('vim-airline/vim-airline')    " Pretty status line
call dein#add('airblade/vim-gitgutter')     " Git changes in gutter

"call dein#add('scrooloose/nerdcommenter')   " Better code commenting
call dein#add('mjp4/vim-scala')       " Support for scala.
let g:scala_scaladoc_indent = 1
call dein#add('junegunn/fzf', { 'build': './install', 'merged': 0 })
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#add('edkolev/tmuxline.vim')
call dein#add('ganwell/rst.vim')

call dein#add('PeterRincker/vim-argumentative')
" <, >,  | Shifting arguments
" [, ],  | Moving between argument boundaries
" a, i,  | New text objects

" ack/ag integration
call dein#add('mileszs/ack.vim')
if executable('ag')
  let g:ackprg = 'ag  --nogroup --nocolor --column'
endif

call dein#add('christoomey/vim-conflicted')
" Merge Failure
call dein#add('craigemery/vim-autotag')
call dein#add('gioele/vim-autoswap')
let g:autoswap_detect_tmux = 1

call dein#end()

if dein#check_install()
  call dein#install()
endif

function! LongStringFormatter()
    let lnum = v:lnum
    let lcount = v:count
    let le = lnum + lcount - 1
    let lb = lnum
    let nochange = 1
    while lb <= le
        exec "normal! ".(lb)."G"
        if match(getline(lb), '" +$') >= 0 && match(getline(lb + 1), '^\s*"') >= 0 && lb + 1 <= le
            exec "normal! J"
            let le = le - 1
        else
            let lb = lb + 1
        endif
        s/" + "//g
    endwhile

    let lb = lnum
    while lb <= le
        if match(getline(lb), '^[^"]\{,40\}"') >= 0 && strlen(getline(lb)) > 80
            exec "normal! ".(lb)."G77|F a\" +\r\""
            let le = le + 1
            let nochange = 0
        else
            let lb = lb + 1
        endif
    endwhile
    return nochange
endfunction

set formatexpr=LongStringFormatter()

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

let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
if g:airline_theme == 'dark'
    for colors in values(a:palette.inactive)
    let colors[2] = 245
    endfor
endif
endfunction

let g:tmuxline_powerline_separators = 0
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '>',
    \ 'right' : '',
    \ 'right_alt' : '<',
    \ 'space' : ' '}

"see :help airline | airline-customisations
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 119,
    \ 'x': 110,
    \ 'y': 128,
    \ 'z': 65,
    \ 'warning': 80,
    \ 'error': 80,
    \ }
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_min_count = 0
let g:airline#extensions#tabline#tab_min_count = 0

nnoremap <silent> [g :tabprev<cr>
nnoremap <silent> ]g :tabnext<cr>
nnoremap <silent> [G :tabfirst<cr>
nnoremap <silent> ]G :tablast<cr>

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


let mapleader=" "

nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>:e<cr>

nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>ts :TestSuite<cr>
nnoremap <silent> <leader>tl :TestLast<cr>

nnoremap <leader>w :vertical resize 84<cr>

inoremap <C-d>d <C-O>:read !date '+\%a \%d \%b \%y'<cr>
inoremap <C-d>t <C-O>:read !date '+\%H:\%M'<cr>
inoremap <C-d>w <C-O>:read !date --date='last Monday' '+w/c \%d/\%m/\%Y'<cr>
inoremap <C-d>t <C-R>=strftime("%H:%M")<cr>
inoremap <C-d>d <C-R>=strftime("%a %d %b %y")<cr>
inoremap <C-d>w <C-R>=strftime("w/c %d/%m/%Y", system("date --date='last Monday' '+%s'"))<cr>
":inoremap <F5> <C-R>=strftime("%c")<CR>

set background=dark

set mouse=
set nomodeline
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set copyindent
set hidden

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
noremap <silent> <leader>v :vsplit<cr>

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
