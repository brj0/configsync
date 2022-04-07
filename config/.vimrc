""""""""""""""""""""""""""""""""""""""""
""" GENERAL
""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w<cr>

" Fast closing
nmap <leader>q :q<cr>

" Make jk do esc
inoremap jk <Esc>

" Shows data name on terminal bar
set title

" Shortcuts for tabs
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" Backspace working as usual
nnoremap <bs> X
set backspace=indent,eol,start " backspace working as usual in insert mode

" Enables copying into os clipboard
set clipboard=unnamedplus

" Enables mouse
set mouse=a

" Show line number
set number

" Show all trailing whitespace
" MUST be inserted before colorscheme command
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" Show snipped sequence <++>
" MUST be inserted before colorscheme command
highlight SnippedSign ctermbg=green ctermfg=black
autocmd ColorScheme * highlight SnippedSign ctermbg=green ctermfg=black
autocmd BufWinEnter * match SnippedSign /<++>/

" Syntax color
colorscheme default " colors
syntax on " Switch Syntax highlighting on

" Show all highlighting colors
ab hitest source<Space>$VIMRUNTIME/syntax/hitest.vim

" Format style
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number deleted by pressing backspace
set shiftwidth=4 " should be the same as softtabstop
set textwidth=120 " Maximal text width
set autoindent " continue with upper indentation
set expandtab " tabs are spaces

" Highlight tabs
set list
set listchars=tab:▸·

" Easier moving/indentation of blocks
vnoremap < <gv
vnoremap > >gv

" Searching
set hlsearch " highlight matches
set ignorecase smartcase " ignores cases for search function
set shortmess-=S " show count of search hits
set incsearch " see search results as you type

" Search down into subfolders
" Provides tab-completion for all file related tasks
set path+=**

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

" Template files
ab temphtml -1read ~/.vim/templates/skeleton.html
ab tempc -1read ~/.vim/templates/skeleton.c
ab tempcpp -1read ~/.vim/templates/skeleton.cpp
ab tempbeamer -1read ~/.vim/templates/beamer.tex
ab templetter -1read ~/.vim/templates/letter.tex


""""""""""""""""""""""""""""""""""""""""
""" LATEX
""""""""""""""""""""""""""""""""""""""""

" Spell check
autocmd FileType tex setlocal spell! spelllang=en_us,de

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


""""""""""""""""""""""""""""""""""""""""
""" PYTHON
""""""""""""""""""""""""""""""""""""""""

" Python debugging
inoremap pdb import pdb; pdb.set_trace()


""""""""""""""""""""""""""""""""""""""""
""" HTML
""""""""""""""""""""""""""""""""""""""""

" Set syntax to jinja for all html files
au BufNewFile,BufRead *.html set syntax=htmljinja

" For html use 2 spaces
autocmd FileType html,htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Spell check
autocmd FileType html,htmldjango setlocal spell! spelllang=en_us

" Snippets
autocmd FileType html,htmldjango inoremap ,. <Esc>"zdiWi<<C-R>z><Enter><Enter></<C-R>z><Enter><++><Esc>2ki<Tab>


""""""""""""""""""""""""""""""""""""""""
""" CSS
""""""""""""""""""""""""""""""""""""""""

" For css use 2 spaces
autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab


""""""""""""""""""""""""""""""""""""""""
""" JAVASCRIPT
""""""""""""""""""""""""""""""""""""""""

" For javascript use 2 spaces
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
