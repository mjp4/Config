setlocal tabstop=2
setlocal shiftwidth=2
setlocal colorcolumn=80
setlocal nowrap

augroup ScalaOnlyCmd
  autocmd!
  "autocmd BufWritePost *.py call DocBuild()
augroup END

