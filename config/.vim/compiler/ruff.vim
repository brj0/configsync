" Avoid loading twice
if exists("current_compiler")
    finish
endif

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

" If makefile exists do not redefine makeprg
if (filereadable('Makefile') || filereadable('makefile'))
    let current_compiler = 'make'
    finish
else
    let current_compiler = 'ruff'
endif

CompilerSet makeprg=ruff
CompilerSet errorformat=%f:%l:%c:\ %m
