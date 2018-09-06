if exists("current_compiler")
  finish
endif
let current_compiler = "cwclog2vim"

"let s:cpo_save = &cpo
"set cpo-=C
CompilerSet makeprg=cwclog2vim\ ~/sprout/plugins/houdini/tmp.log
CompilerSet errorformat=%*[^\"]\"%f\"%*\\D%l:\ %m

"let &cpo = s:cpo_save
"unlet s:cpo_save
