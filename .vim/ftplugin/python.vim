setlocal tabstop=4
setlocal shiftwidth=4
setlocal colorcolumn=80
setlocal nowrap

augroup PythonOnlyCmd
  autocmd!
  autocmd BufWritePost *.py call DocBuild()
augroup END

