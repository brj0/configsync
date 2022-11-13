" Avoid loading twice
if exists("current_compiler")
    finish
endif

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

" If makefile do not redefine makeprg
if (filereadable('Makefile') || filereadable('makefile'))
    let current_compiler = 'make'
    finish
else
    let current_compiler = 'rubber'
endif

CompilerSet makeprg=rubber\ \-df\ \-W\ all\ %:r
CompilerSet errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
