"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" VIM CONFIGURATION FILE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" call plug#begin('~/.vim/plugged')

" " R support within vim
" Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

" " Initialize plugin system
" call plug#end()

" " vim-plug automatically executes filetype plugin indent on and syntax enable
" filetype indent off

" Manually add file-type-plugins in ~/.vim/pack/*/opt/
" ab AddPlug runtime! ALL ftplugin/*.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" GENERAL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Local leader for plugins
let maplocalleader = "<"

" Fast saving
nmap <leader>w :w<cr>

" Save changes in files needing sudo permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Fast closing
nmap <leader>q :q<cr>

" Make jk do esc
inoremap jk <Esc>

" Open this file in new tab
ab vimrc tabnew $MYVIMRC<CR>

" Modify time waited for key codes and mapped keys to complete. Fixes long
" waiting time after pressing <Esc>O in insert mode.
set timeout timeoutlen=1000 ttimeoutlen=100

" Map to something useful
nnoremap ö ;
nnoremap é ,
nnoremap ä :

" Minimum line numbers above/under cursor
set scrolloff=5

" Shows data name on terminal bar
set title

" Shortcuts for tabs
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>
nnoremap tm :tabm<Space>

" Always show tabline with filename at the top
set showtabline=2

" Open working directory in vertical split
noremap <leader>t :vsplit<CR>:e .<CR>:vertical resize 30<CR>

" Change the direction of new splits
set splitbelow
set splitright

" Backspace working as usual in normal and insert mode
nnoremap <bs> X
set backspace=indent,eol,start

" Enables copying into os clipboard
set clipboard=unnamedplus

" Enables mouse
set mouse=a

" Use relative line numbers
set number
set rnu

" Toggle between absolute and relative line numbers
nnoremap <leader>l :set rnu!<cr>

" Show the line and column number of the cursor position at the bottom
set ruler

" Turn off backup sawp-files
set noswapfile

" Show incomplete commands
set showcmd

" Map Q to formatting instead of Ex mode
map Q gq

" Show all trailing whitespace
" MUST be inserted before colorscheme command
highlight ExtraWhitespace ctermbg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
autocmd BufWinEnter * syntax match ExtraWhitespace /\s\+$/ containedin=ALL

" Show snipped sequence <++>
" MUST be inserted before colorscheme command
highlight SnippedSign ctermbg=green ctermfg=black
autocmd ColorScheme * highlight SnippedSign ctermbg=green ctermfg=black
autocmd BufWinEnter * syntax match SnippedSign /<++>/ containedin=ALL

" Syntax color
colorscheme default
syntax on

" Show all highlighting colors
ab hitest source<Space>$VIMRUNTIME/syntax/hitest.vim

" Copy indent from current line when starting new line using o, O, <CR>
set autoindent

" Tabs are spaces
set expandtab

" Rounds the indent spacing to the next multiple of shiftwidth
set shiftround

" 1 tab == 4 spaces
" tabstop: Number of visual spaces per tab
" softtabstop: Number deleted by pressing backspace
" shiftwidth: Number of spaces to use for autoindent with <<,  >>
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Use 2 spaces for certain filetypes
autocmd FileType css,html,htmldjango,javascript,tex setlocal tabstop=2 softtabstop=2 shiftwidth=2

" Highlight tabs
set list
set listchars=tab:▸·

" Easier moving/indentation of blocks
vnoremap < <gv
vnoremap > >gv

" Move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Reselect pasted text, similar to gv
nnoremap gp `[v`]

" Paste last thing yanked, not deleted
vnoremap <leader>p "0p
vnoremap <leader>P "0P
noremap <leader>p "0p
noremap <leader>P "0P

" Highlight search results
set hlsearch

" Disable highlight
nnoremap <leader><CR> :noh<CR>

" Remap for fast searching
nnoremap <Space> /
nnoremap <leader><Space> ?

" See search results as you type
set incsearch

" Ignores cases for search function except if search term contains capital
" letters
set ignorecase
set smartcase

" Show count of search hits (needs at least vim 8.2)
set shortmess-=S

" Search down into subfolders
" Provides tab-completion for all file related tasks
set path+=**

" Search project for current word and highlight it
nnoremap <leader>* /<C-R><C-W>\C<CR>N:grep! -R <cword> * --exclude-dir={.git,tmp,log}<CR><CR>

" Search current selection
vnoremap * "zy/<C-R>z<Enter>
vnoremap # "zy?<C-R>z<Enter>

" Search and replace word under cursor
nnoremap <leader>r *Ncw

" Moving fast in quickfix
let s:quickfix_on = 0

function! s:ToggleQuickfix()
    if s:quickfix_on
        execute ":ccl"
        let s:quickfix_on = 0
    else
        execute ":cw"
        let s:quickfix_on = 1
    endif
endfunction

nnoremap <leader>f :call <SID>ToggleQuickfix()<CR>
nnoremap <leader>n :cn<Enter>
nnoremap <leader>N :cp<Enter>

" Display all matching commands/files when we tab complete
set wildmenu

" Ctrl-x Ctrl-o completion
set omnifunc=syntaxcomplete#Complete

" Navigate within snippets
inoremap ,, <Esc>/<++><Enter>"_c4l
vnoremap ,, <Esc>/<++><Enter>"_c4l
map ,, <Esc>/<++><Enter>"_c4l

" Dictionary spell check
nnoremap <leader>de :set nospell<CR>:setlocal spell spelllang=en_us<CR>
nnoremap <leader>dg :set nospell<CR>:setlocal spell spelllang=de<CR>
nnoremap <leader>dm :set nospell<CR>:setlocal spell spelllang=en_us,de<CR>
nnoremap <leader>dd :set nospell<CR>
autocmd FileType tex setlocal spell spelllang=en_us,de
autocmd FileType html,htmldjango setlocal spell spelllang=en_us

" Template files
ab temphtml -1read ~/.vim/templates/skeleton.html
ab tempc -1read ~/.vim/templates/skeleton.c
ab tempsh -1read ~/.vim/templates/skeleton.sh
ab tempcpp -1read ~/.vim/templates/skeleton.cpp
ab tempbeamer -1read ~/.vim/templates/beamer.tex
ab templetter -1read ~/.vim/templates/letter.tex

" Yank to tmux buffer
nnoremap <silent><leader>yy yy<Esc>:echo system('tmux set-buffer ' . shellescape(getreg('"')))<CR>:echo "yanked to tmux buffer"<CR>
vnoremap <silent><leader>y y<Esc>:echo system('tmux set-buffer ' . shellescape(getreg('"')))<CR>:echo "yanked to tmux buffer"<CR>

" Inserts the current line with a <CR>, starting at the cursor position (first
" command) or simply a <CR> (second command), into the first tmux pane. Can be
" used to process line by line with the python interpreter.
function! s:RunInConsole(mode)
    " Copy from start of visual block.
    if a:mode == "v"
        let start = getpos("'<")[2] - 1
        let code = shellescape(getline('v')[start:])
    " Copy from start of cursor.
    else
        norm "zy$
        let code = shellescape(getreg('z'))
    endif
    " Ignore empty line
    if code !~ "^'\\s*'$"
        silent call system('tmux set-buffer ' . code)
        silent call system('tmux paste-buffer -t 1')
    endif
    silent call system('tmux send-keys -t 1 Enter')
endfunction

nnoremap <leader>e :call <SID>RunInConsole("n")<CR>j
vnoremap <leader>e :call <SID>RunInConsole("v")<CR>
nnoremap <leader>E :call system('tmux send-keys -t 1 Enter')<CR>

" Make Y work like C, D
nnoremap Y y$

" Enable :Man command to access man pages
runtime ftplugin/man.vim

" Open url under curser
nmap gx :!sensible-browser <C-r><C-a><CR><CR>

" Swap word with next word.
nmap <leader>s :s/\([[:alnum:]#_="'.&*+-]*\%#[[:alnum:]#_="'.&*+-]\+\)\([, ]\+\)\([[:alnum:]#_="'.&*+-]\+\)/\3\2\1/<CR><C-o><C-l>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" COMMENT / UNCOMMENT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:comment_map_start = {
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "css": '\/\*',
    \   "html": '<!--',
    \   "htmldjango": '<!--',
    \   "javascript": '\/\/',
    \   "python": '#',
    \   "sh": '#',
    \   "tex": '%',
    \   "tmux": '#',
    \   "vim": '"',
    \ }

let s:comment_map_end = {
    \   "css": '\*\/',
    \   "html": '-->',
    \   "htmldjango": '-->',
    \ }

function! s:Comment()
if getline('.') =~ "^\\s*$"
    " Ignore empty line
    return 1
endif
if has_key(s:comment_map_start, &filetype)
    let comment_start = s:comment_map_start[&filetype]
    " Comment the line
    execute "silent s/^\\(\\s*\\)/\\1" . comment_start . " /"
else
    echo "No comment leader found for filetype"
end
if has_key(s:comment_map_end, &filetype)
    let comment_end = s:comment_map_end[&filetype]
    " Comment the line
    execute "silent s/$/ " . comment_end . "/"
endif
endfunction

function! s:UnComment()
if has_key(s:comment_map_start, &filetype)
    let comment_start = s:comment_map_start[&filetype]
    if getline('.') =~ "^\\s*" . comment_start
        " Uncomment the line
        execute "silent s/^\\(\\s*\\)" . comment_start . " \\=/\\1/"
    endif
else
    echo "No comment leader found for filetype"
end
if has_key(s:comment_map_end, &filetype)
    let comment_end = s:comment_map_end[&filetype]
    if getline('.') =~ comment_end . "$"
        " Uncomment the line
        execute "silent s/ \\=" . comment_end . "$//"
    endif
endif
endfunction

" Comment line/lines of code
nnoremap <leader>c :call <SID>Comment()<CR>
vnoremap <leader>c :call <SID>Comment()<CR>

" Uncomment line/lines of code
nnoremap <leader>C :call <SID>UnComment()<CR>
vnoremap <leader>C :call <SID>UnComment()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" LATEX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set maximal text width
autocmd FileType tex set textwidth=90

" Compiling / Bibliography
" Add file my_bibliography.bib in same folder as my_file.tex
" Add to my_file.tex header:
"   \usepackage[backend=biber]{biblatex}
"   \addbibresource{my_bibliography.bib}
" Add if non-cited files should be included
"   \nocite{*} or \nocite{<bibkey>}
" Print bibliography with
"   \printbibliography
" Correct command ordering:
"   1. pdflatex my_file.tex
"   2. biber my_file
"   3. pdflatex my_file.tex

" pdflatex my_file.tex
autocmd FileType tex map <f2> :w<CR>:! pdflatex %<CR><CR>

" Open my_file.pdf
autocmd FileType tex map <f3> :! xdg-open %:r.pdf & disown<CR><CR>

" biber my_file
autocmd FileType tex map <f4> :w<CR>:! biber %:r<CR><CR>

" Full command list:
autocmd FileType tex map <f5> <f2><f4><f2><f3>

" Snippets
autocmd FileType tex inoremap ,tb \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap ,ti \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ,tc \textcite{}<++><Esc>T{i
autocmd FileType tex inoremap ,fc \footcite{}<++><Esc>T{i
autocmd FileType tex inoremap ,u \usepackage{}<Esc>T{i
autocmd FileType tex noremap ,u o\usepackage{}<Esc>T{i
autocmd FileType tex inoremap ,ig \includegraphics[width=]{<++>}<Esc>T=i

autocmd FileType tex inoremap ,fr \begin{frame}{}<Enter><++><Enter>\end{frame}<Enter><Enter><++><Esc>4k$i
autocmd FileType tex inoremap ,bl \begin{block}{}<Enter><++><Enter>\end{block}<Enter><++><Esc>3k$i
autocmd FileType tex inoremap ,en \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><++><Esc>2ki
autocmd FileType tex inoremap ,it \begin{itemize}<Enter><Enter>\end{itemize}<Enter><++><Esc>2ki\item<Space>
autocmd FileType tex inoremap ,ce \begin{center}<Enter><Enter>\end{center}<Enter><++><Esc>2ki
autocmd FileType tex inoremap ,ta \begin{tabular}{}<Enter><++><Enter>\end{tabular}<Enter><++><Esc>3k$i

" autocmd FileType tex inoremap \\ \\<Enter>
autocmd FileType tex inoremap ,ii <Enter>\item<Space>
autocmd FileType tex inoremap ,- <Esc>"zdiWi\<C-R>z{}<++><Esc>T{i
autocmd FileType tex inoremap ,. <Esc>"zdiWi\begin{<C-R>z}<Enter><Enter>\end{<C-R>z}<Enter><++><Esc>2ki


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PYTHON
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Python debugging
autocmd FileType python noremap <leader>b <Esc>oimport pdb; pdb.set_trace()<Esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" HTML
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set syntax to jinja for all html files
au BufNewFile,BufRead *.html set syntax=htmljinja

" Snippets
autocmd FileType html,htmldjango inoremap ,. <Esc>"zdiWi<<C-R>z><Enter><Enter></<C-R>z><Enter><++><Esc>2ki<Tab>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" C/C++
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Switch between header and source files
autocmd FileType c,cpp noremap <Leader>oh :e %<.h<CR>
autocmd FileType c noremap <Leader>oc :e %<.c<CR>
autocmd FileType cpp noremap <Leader>oc :e %<.cpp<CR>

