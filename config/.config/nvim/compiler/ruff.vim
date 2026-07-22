" Avoid loading twice
if exists("current_compiler")
    finish
endif

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=ruff\ check\ --output-format=concise
CompilerSet errorformat=%f:%l:%c:\ %m
