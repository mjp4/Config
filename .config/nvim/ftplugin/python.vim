setlocal colorcolumn=80
setlocal nowrap

set makeprg=flake8\ %\ &&\ pylint\ --reports=n\ --disable=locally-disabled\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %
set formatexpr=
set formatprg=autopep8\ -
" augroup PythonOnlyCmd
"   autocmd!
"   autocmd BufWritePost *.py call DocBuild()
" augroup END

