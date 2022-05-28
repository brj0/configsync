"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" call plug#begin('~/.vim/plugged')
"
" " R support within vim
" Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
"
" " Initialize plugin system
" call plug#end()
"
" " vim-plug automatically executes filetype plugin indent on and syntax enable
" filetype indent off

" Manually add file-type-plugins in ~/.vim/pack/*/opt/
ab AddPlug runtime! ALL ftplugin/*.vim


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

" Fast closing
nmap <leader>q :q<cr>

" Make jk do esc
inoremap jk <Esc>

" Map to something useful
nnoremap ö ;
nnoremap é ,

" Minimum line numbers above/under curser
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

" Always show tabline
set showtabline=2

" Open filesystem in vertical split
noremap <leader>t :vsplit<CR>:e .<CR>:vertical resize 30<CR>

" change the direction of new splits
set splitbelow
set splitright

" Backspace working as usual
nnoremap <bs> X
set backspace=indent,eol,start " backspace working as usual in insert mode

" Enables copying into os clipboard
set clipboard=unnamedplus

" Enables mouse
set mouse=a

" Show line number
set number

" Set ruler
set ruler

" Show incomplete commands
set showcmd

" Map Q to formatting instead of Ex mode
map Q gq

" Toggle between absolute and relative line numbers
set rnu
nnoremap <leader>rn :set rnu!<cr>

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
colorscheme default " colors
syntax on " Switch Syntax highlighting on

" Show all highlighting colors
ab hitest source<Space>$VIMRUNTIME/syntax/hitest.vim

" Format style
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number deleted by pressing backspace
set shiftwidth=4 " should be the same as softtabstop
set autoindent " continue with upper indentation
set expandtab " tabs are spaces

" Rounds the indent spacing to the next multiple of shiftwidth
set shiftround

" Use 2 spaces for certain filetypes
autocmd FileType css,html,htmldjango,javascript,tex setlocal tabstop=2 softtabstop=2 shiftwidth=2

" Highlight tabs
set list
set listchars=tab:▸·

" Easier moving/indentation of blocks
vnoremap < <gv
vnoremap > >gv

" Moving Lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Reselect pasted text
nnoremap gp `[v`]

" Reclace selected text with "-register without changing it
vnoremap <leader>p "_dP

" Searching
set hlsearch " highlight matches
set ignorecase smartcase " ignores cases for search function
set shortmess-=S " show count of search hits
set incsearch " see search results as you type

" Search down into subfolders
" Provides tab-completion for all file related tasks
set path+=**

" Search project for current word
nnoremap <leader>* :grep -R <cword> * --exclude-dir={.git,tmp,log}<CR><CR>

" Search current selection
vnoremap * "zy/<C-R>z<Enter>
vnoremap # "zy?<C-R>z<Enter>

" Search and replace word under curser
nnoremap <leader>R *Ncw

" Display all matching commands/files when we tab complete
set wildmenu

" ctrl-x ctrl-o completion
set omnifunc=syntaxcomplete#Complete

" Navigate within snippets
inoremap ,, <Esc>/<++><Enter>"_c4l
vnoremap ,, <Esc>/<++><Enter>"_c4l
map ,, <Esc>/<++><Enter>"_c4l

" Spell check
map <f6> :setlocal spell! spelllang=en_us<CR>
map <f7> :setlocal spell! spelllang=de<CR>
autocmd FileType tex setlocal spell! spelllang=en_us,de
autocmd FileType html,htmldjango setlocal spell! spelllang=en_us

" Template files
ab temphtml -1read ~/.vim/templates/skeleton.html
ab tempc -1read ~/.vim/templates/skeleton.c
ab tempcpp -1read ~/.vim/templates/skeleton.cpp
ab tempbeamer -1read ~/.vim/templates/beamer.tex
ab templetter -1read ~/.vim/templates/letter.tex

" Yank to tmux buffer
nnoremap <leader>yy yy<Esc>:echo system('tmux set-buffer ' . shellescape(getreg('"')))<CR>:echo "yanked to tmux buffer"<CR>
vnoremap <leader>y y<Esc>:echo system('tmux set-buffer ' . shellescape(getreg('"')))<CR>:echo "yanked to tmux buffer"<CR>

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
    \   "vim": '"',
    \   "tex": '%',
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

vnoremap <leader>c :call <SID>Comment()<CR>
nnoremap <leader>c :call <SID>Comment()<CR>
vnoremap <leader>C :call <SID>UnComment()<CR>
nnoremap <leader>C :call <SID>UnComment()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" LATEX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set maximal textwidth
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

autocmd FileType tex inoremap \\ \\<Enter>
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
