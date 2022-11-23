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
    let current_compiler = 'latexmk'
endif

CompilerSet makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
CompilerSet errorformat=%f:%l:\ %m
