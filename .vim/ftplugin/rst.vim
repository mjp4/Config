setlocal tabstop=2
setlocal shiftwidth=2

function! Rst2(format)
  let command = "rst2" . a:format
  let input = expand('%')
  let output = expand('%:r') . "." . a:format
  execute "Dispatch! " . command . " " . input . " " . output
endfunction

setlocal colorcolumn=80
setlocal nowrap

noremap <silent> <leader>rh :call Rst2('html')<cr>
noremap <silent> <leader>rp :call Rst2('pdf')<cr>
noremap <silent> <leader>ro :call Rst2('odt')<cr>
noremap <silent> <leader>rl :call Rst2('latex')<cr>

augroup RstOnly
  autocmd!
  autocmd BufWritePost *.rst call DocBuild()
augroup END

set formatlistpat=\\v^\\s*(\\d+\\|#\\|\*)[\\]:.)}\\t\ ]\\s*
set formatoptions+=n
