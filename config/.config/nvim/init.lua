--[[
     _       _ _     _
    (_)     (_) |   | |
     _ _ __  _| |_  | |_   _  __ _
    | | '_ \| | __| | | | | |/ _` |
    | | | | | | |_ _| | |_| | (_| |
    |_|_| |_|_|\__(_)_|\__,_|\__,_|

    Neovim configuration in Lua
--]]



-- Set leader and local leader (plugins) keys
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ","
vim.g.maplocalleader = "<"



-- [[ Setting options ]]

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Show file name on terminal bar
vim.opt.title = true

-- Always show tabline with filename at the top
vim.opt.showtabline = 2

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Use relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching unless \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Ignore some files when we tab complete
vim.opt.wildignore = "*.pyc,*.nbc,*.nbi,*.o,*.d,*.cmake,*.bin,*.so,*.egg-info/"

-- Turn off backup swap files
vim.opt.swapfile = false

-- Preview substitutions live, as we type
vim.opt.inccommand = 'split'

-- Show which line the cursor is on
vim.opt.cursorline = true

-- Tabs are spaces
vim.opt.expandtab = true

-- Rounds the indent spacing to the next multiple of `shiftwidth`
vim.opt.shiftround = true

-- Use 4 spaces instead of tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Search down into subfolders
vim.opt.path:append("**")

-- Ctrl-x Ctrl-o completion
vim.opt.omnifunc = "syntaxcomplete#Complete"

-- Adjust timeouts
vim.opt.timeoutlen = 800
vim.opt.ttimeoutlen = 100

-- Disable automatic buffer hiding
vim.opt.hidden = false



-- [[ Basic key mappings ]]

-- Backspace working as usual in normal and insert mode
vim.keymap.set('n', '<bs>', 'X', { noremap = true })

-- Fast saving and quitting
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })

-- Make jk do <Esc>
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Fast searching
vim.keymap.set('n', '<Space>', '/', { noremap = true })
vim.keymap.set('n', '<leader><Space>', '?', { noremap = true })

-- Save changes in files needing sudo permission
vim.keymap.set('c', 'w!!', "execute 'silent! write !sudo tee % >/dev/null' | edit!", { noremap = true })

-- Fast quickfix navigation
vim.keymap.set('n', "'f", ':cprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', "üf", ':cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', "'F", ':cfirst<CR>', { noremap = true, silent = true })
vim.keymap.set('n', "üF", ':clast<CR>', { noremap = true, silent = true })
vim.keymap.set('n', "'o", ':colder<CR><CR>', { noremap = true, silent = true })
vim.keymap.set('n', "üo", ':cnewer<CR><CR>', { noremap = true, silent = true })

-- Add empty line above/below
vim.keymap.set('n', "'<Space>", 'O<Esc>j', { noremap = true })
vim.keymap.set('n', "ü<Space>", 'o<Esc>k', { noremap = true })

-- Quick tab navigation
vim.keymap.set('n', 'tn', ':tabnew ', { noremap = true })
vim.keymap.set('n', 'tf', ':tabfind ', { noremap = true })
vim.keymap.set('n', 'tk', ':tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tj', ':tabprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'th', ':tabfirst<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tl', ':tablast<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tm', ':tabm ', { noremap = true })

-- Remap keys to something useful
vim.keymap.set('n', 'ö', ';', { noremap = true })
vim.keymap.set('n', 'é', ',', { noremap = true })
vim.keymap.set('n', 'ä', ':', { noremap = true })
vim.keymap.set('v', 'ä', ':', { noremap = true })

-- Compilation shortcuts
--  Compile file and open quickfix if there are errors
vim.keymap.set('n', '<leader>mm', ':w<CR>:silent make! | redraw! | cw<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>mf', ':w<CR>:silent make! % | redraw! | cw<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>mb', ':w<CR>:silent make! -C build | redraw! | cw<CR>', { noremap = true, silent = true })

--  Compile file in debug mode and open quickfix if there are errors
vim.keymap.set('n', '<leader>md', ':w<CR>:silent make! debug | redraw! | cw<CR>', { noremap = true, silent = true })

--  Run binary and display output in quickfix
vim.keymap.set('n', '<leader>mo', ':cex system("make run")<CR>:copen<CR>', { noremap = true, silent = true })

--  Run binary
vim.keymap.set('n', '<leader>mr', ':make run<CR>', { noremap = true, silent = true })

-- Open entry in quickfix in new tab
vim.keymap.set('n', 'tt', '<C-W><Enter><C-W>T', { noremap = true, silent = true })

-- Open working directory in vertical split
vim.keymap.set('n', '<leader>t', ':30vsplit .<CR>', { noremap = true, silent = true })

-- Toggle between absolute and relative line numbers
vim.keymap.set('n', '<leader>l', function()
    vim.opt.relativenumber = not vim.wo.relativenumber
end, { noremap = true, silent = true })

-- Map Q to formatting instead of Ex mode
vim.keymap.set('v', 'Q', 'gq', { noremap = true, silent = true })

-- Easier moving/indentation of blocks
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- Move between windows
vim.keymap.set('n', '<C-j>', '<C-W>j', { noremap = true, silent = true, desc = "Move to window below" })
vim.keymap.set('n', '<C-k>', '<C-W>k', { noremap = true, silent = true, desc = "Move to window above" })
vim.keymap.set('n', '<C-h>', '<C-W>h', { noremap = true, silent = true, desc = "Move to window left" })
vim.keymap.set('n', '<C-l>', '<C-W>l', { noremap = true, silent = true, desc = "Move to window right" })

-- Reselect pasted text
vim.keymap.set('n', 'gp', '`[v`]', { noremap = true, silent = true })

-- Paste last thing yanked, not deleted
vim.keymap.set('v', '<leader>p', '"0p', { noremap = true })
vim.keymap.set('v', '<leader>P', '"0P', { noremap = true })
vim.keymap.set('n', '<leader>p', '"0p', { noremap = true })
vim.keymap.set('n', '<leader>P', '"0P', { noremap = true })

-- Clear search highlights and force a screen redraw
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>:redraw!<CR>', { noremap = true, silent = true })

-- Make 'n' always search forward
vim.keymap.set('n', 'n', "(v:searchforward ? 'n' : 'N')", { noremap = true, expr = true })
vim.keymap.set('n', 'N', "(v:searchforward ? 'N' : 'n')", { noremap = true, expr = true })

-- Don't use ignorecase when using * and #
vim.keymap.set('n', '*', ":let @/='\\C\\<' .. expand('<cword>') .. '\\>'<CR>:let v:searchforward=1<CR>n", { noremap = true, silent = true })
vim.keymap.set('n', '#', ":let @/='\\C\\<' .. expand('<cword>') .. '\\>'<CR>:let v:searchforward=0<CR>n", { noremap = true, silent = true })
vim.keymap.set('n', 'g*', ":let @/='\\C' .. expand('<cword>') <CR>:let v:searchforward=1<CR>n", { noremap = true, silent = true })
vim.keymap.set('n', 'g#', ":let @/='\\C' .. expand('<cword>') <CR>:let v:searchforward=0<CR>n", { noremap = true, silent = true })

-- Search project for current word and highlight it
vim.keymap.set("n", "<leader>*", function()
    local word = vim.fn.expand('<cword>')
    vim.cmd("/\\C" .. word)
    vim.cmd('normal! N')
    if vim.fn.executable("rg") == 1 then
        -- Use ripgrep if available (gj is invalid in this case)
        vim.cmd("silent! grep! " .. vim.fn.shellescape(word) .. " **/*")
    else
        -- Fall back to vimgrep
        vim.cmd("vimgrep /" .. word .. "/gj **/*")
    end
    vim.cmd("cwindow")
end, { desc = "Recursive grep and highlight word" })

-- Search current selection
vim.keymap.set('v', '*', '"zy/<C-R>z<Enter>', { noremap = true })
vim.keymap.set('v', '#', '"zy?<C-R>z<Enter>', { noremap = true })

-- Search and replace word under cursor
vim.keymap.set('n', '<leader>r', "/\\<<C-R><C-W>\\>\\C<CR>Ncw", { noremap = true, silent = true })

-- Moving fast in quickfix
--  Toggle quickfix window
vim.keymap.set('n', '<leader>f', function()
    -- Check if the quickfix window is open by checking the window's height
    local quickfix_win = vim.fn.getqflist({ winid = 0 }).winid
    if quickfix_win ~= 0 then
        -- If the quickfix window is open, close it
        vim.cmd('cclose')
    else
        -- If the quickfix window is not open, open it
        vim.cmd('copen')
    end
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>n', ':cn<Enter>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>N', ':cp<Enter>', { noremap = true, silent = true })

-- Navigate within snippets
vim.keymap.set('i', '<leader><leader>', '<Esc>/<++><Enter>"_c4l', { noremap = true })
vim.keymap.set('v', '<leader><leader>', '<Esc>/<++><Enter>"_c4l', { noremap = true })
vim.keymap.set('n', '<leader><leader>', '<Esc>/<++><Enter>"_c4l', { noremap = true })

-- Dictionary spell check
vim.keymap.set('n', '<leader>de', ':set nospell<CR>:setlocal spell spelllang=en_us<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dg', ':set nospell<CR>:setlocal spell spelllang=de<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dm', ':set nospell<CR>:setlocal spell spelllang=en_us,de<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dd', ':set nospell<CR>', { noremap = true, silent = true })

-- Toggle between normal motion and soft-wrapped g-motion
local wrap_keys_enabled = false
local function toggle_motion_wrap()
    if wrap_keys_enabled then
        -- Reset to normal `j`, `k`
        vim.api.nvim_del_keymap("n", "j")
        vim.api.nvim_del_keymap("n", "k")
        vim.api.nvim_del_keymap("n", "0")
        vim.api.nvim_del_keymap("n", "^")
        vim.api.nvim_del_keymap("n", "$")
        vim.api.nvim_del_keymap("v", "j")
        vim.api.nvim_del_keymap("v", "k")
        vim.api.nvim_del_keymap("v", "0")
        vim.api.nvim_del_keymap("v", "^")
        vim.api.nvim_del_keymap("v", "$")
        wrap_keys_enabled = false
    else
        -- Remap for soft-wrapped movement
        vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
        vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
        vim.keymap.set("n", "0", "g0", { noremap = true, silent = true })
        vim.keymap.set("n", "^", "g^", { noremap = true, silent = true })
        vim.keymap.set("n", "$", "g$", { noremap = true, silent = true })
        vim.keymap.set("v", "j", "gj", { noremap = true, silent = true })
        vim.keymap.set("v", "k", "gk", { noremap = true, silent = true })
        vim.keymap.set("v", "0", "g0", { noremap = true, silent = true })
        vim.keymap.set("v", "^", "g^", { noremap = true, silent = true })
        vim.keymap.set("v", "$", "g$", { noremap = true, silent = true })
        wrap_keys_enabled = true
    end
end

vim.keymap.set("n", "<leader>g", toggle_motion_wrap, { noremap = true, silent = true })

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Sends the current line or selected text to the first tmux pane for execution.
-- This allows running code line by line in an interpreter within tmux.
function RunInConsole(register)
    local code = vim.fn.getreg(register)

    -- If last line ends without CR, add one manually
    if not code:match(".*\n$") then
        code = code .. "\n"
    end

    -- Split the code into chunks of 1024 characters (to prevent buffer overflow)
    local chunk_size = 1024
    local code_chunks = {}

    for i = 1, #code, chunk_size do
        table.insert(code_chunks, code:sub(i, i + chunk_size - 1))
    end

    -- Send each chunk to tmux
    for _, chunk in ipairs(code_chunks) do
        vim.fn.system("tmux set-buffer " .. vim.fn.shellescape(chunk))
        vim.fn.system("tmux paste-buffer -t 1")
    end
end

vim.keymap.set("n", "<leader>e", "\"zy$:lua RunInConsole('z')<CR>j", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>e", "$\"zy'>:lua RunInConsole('z')<CR>j", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>E", function()
    vim.fn.system("tmux send-keys -t 1 Enter")
end, { noremap = true, silent = true })

-- Yank to tmux buffer
local function yank_to_tmux()
    local yanked_text = vim.fn.getreg('"')
    vim.fn.system('tmux set-buffer ' .. vim.fn.shellescape(yanked_text))
    print("Yanked to tmux buffer")
end

vim.keymap.set("n", "<leader>yy", function()
    vim.cmd("normal! yy") -- Yank current line
    yank_to_tmux()
end, { silent = true, desc = "Yank line to tmux buffer" })

vim.keymap.set("v", "<leader>y", function()
    vim.cmd("normal! y") -- Yank selected text
    yank_to_tmux()
end, { silent = true, desc = "Yank selection to tmux buffer" })

-- Change tmux session
vim.keymap.set("n", "<C-@>", ":!tmux-sessionizer<CR><CR>", { silent = true, desc = "Change tmux session" })

-- Make Y behave like C and D (yank until end of line)
vim.keymap.set("n", "Y", "y$", { silent = true, desc = "Yank to end of line" })



-- [[ Custom Commands ]]

-- Open neovim config directory in a new tab
vim.api.nvim_create_user_command('OpenConfig', function()
    vim.cmd('tabnew ~/.config/nvim')
end, {})

-- Show all highlighting colors
vim.api.nvim_create_user_command('Hitest', 'source $VIMRUNTIME/syntax/hitest.vim', {})

-- Template files
local templates = {
    Tempbeamer = { path = "~/.config/nvim/templates/beamer.tex", ft = "tex" },
    Tempc = { path = "~/.config/nvim/templates/skeleton.c", ft = "c" },
    Tempcpp = { path = "~/.config/nvim/templates/skeleton.cpp", ft = "cpp" },
    Temphtml = { path = "~/.config/nvim/templates/skeleton.html", ft = "html" },
    Templetter = { path = "~/.config/nvim/templates/letter.tex", ft = "tex" },
    Tempm = { path = "~/.config/nvim/templates/Makefile", ft = "make" },
    Tempsh = { path = "~/.config/nvim/templates/skeleton.sh", ft = "sh" },
}

for cmd, data in pairs(templates) do
    vim.api.nvim_create_user_command(cmd, function()
        vim.cmd("silent! read " .. data.path)
        vim.cmd("silent! normal! kJ")
        vim.bo.filetype = data.ft
    end, {})
end



-- [[ Basic Autocommands ]]

-- Wrap text at the end of a word
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex", "markdown" },
    command = "setlocal linebreak"
})

-- Hack to make netrw wait for the tab shortcuts.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "tt", "<Nop>", { noremap = true })
    end,
})

-- Use 2 spaces for certain file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "css", "html", "htmldjango", "javascript" },
    command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2"
})

-- Enable spell checking in specific file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"tex", "markdown", "html", "htmldjango"},
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us,de"
    end
})

-- Auto-enable motion wrap for certain file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex", "markdown" },
    callback = function()
        if not wrap_keys_enabled then
        toggle_motion_wrap()
        end
    end
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Automatically close man pages with 'q'
vim.api.nvim_create_autocmd("FileType", {
    pattern = "man",
    callback = function()
        vim.keymap.set("n", "q", "<cmd>quit<CR>", { buffer = true, silent = true, desc = "Close man page with 'q'" })
    end,
})



-- [[ LaTeX ]]

-- Compiling / Bibliography
-- ========================
-- File my_bibliography.bib and sty/bst-files in same folder as my_file.tex
-- (alternatively include bibliography in tex file with package 'filecontents')
-- Add if non-cited files should be included
--   \nocite{*} or \nocite{<bibkey>}
--
-- 1. Possibility - Biber/BibLaTeX
-- Add to my_file.tex header:
--   \usepackage[backend=biber]{biblatex}
--   \addbibresource{my_bibliography.bib}
-- Print bibliography with
--   \printbibliography
-- Correct command ordering:
--   1. pdflatex my_file.tex
--   2. biber my_file
--   3. pdflatex my_file.tex
--
-- 2. Possibility - BibTeX
-- Print bibliography with
--   \bibliography{my_bibliography}
-- Correct command ordering:
--   1. pdflatex my_file.tex
--   2. bitex my_file.aux
--   3. pdflatex my_file.tex
--   4. pdflatex my_file.tex

-- Easy compilation with latexmk or rubber
--   latexmk my_file.tex
--   rubber my_file

vim.api.nvim_create_augroup("LatexCommands", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = "LatexCommands",
    pattern = "tex",
    callback = function()
        -- latexmk (automatic compilation tool)
        vim.cmd("compiler latexmk")

        -- pdflatex my_file.tex
        vim.keymap.set("n", "<F2>", ":w<CR>:! pdflatex %<CR><CR>", { buffer = true, desc = "Compile LaTeX with pdflatex" })

        -- biber my_file (for bibliography management)
        vim.keymap.set("n", "<F4>", ":w<CR>:! biber %:r<CR><CR>", { buffer = true, desc = "Run biber for bibliography" })

        -- Full command list (Biber: pdflatex -> biber -> pdflatex)
        vim.keymap.set("n", "<F5>", "<F2><F4><F2><F3>", { buffer = true, desc = "Full compilation (pdflatex -> biber -> pdflatex)" })

        -- Delete auxiliary files (log, aux, toc, bbl, ...) but keep the PDF
        vim.keymap.set("n", "<leader>mc", ":cd %:p:h<CR>:!rm -f *.{aux,bcf,bbl,blg,dvi,fdb_latexmk,fls,log,nav,out,rubbercache,snm,toc,xml}<CR><CR>", { buffer = true, desc = "Clean auxiliary files" })

        -- Open generated PDF file
        vim.keymap.set("n", "<F3>", ":! xdg-open %:r.pdf & disown<CR><CR>", { buffer = true, desc = "Open PDF with xdg-open" })
        vim.keymap.set("n", "<leader>mo", ":! xdg-open %:r.pdf & disown<CR><CR>", { buffer = true, desc = "Open PDF with xdg-open" })
        vim.keymap.set("n", "<leader>mz", ":! zathura %:r.pdf & disown<CR><CR>", { buffer = true, desc = "Open PDF with zathura" })

        -- Define LaTeX snippets
        local snippet_mappings = {
            ["<leader>tb"] = "\\textbf{}<++><Esc>T{i}",  -- Bold text
            ["<leader>ti"] = "\\textit{}<++><Esc>T{i}",  -- Italic text
            ["<leader>tc"] = "\\textcite{}<++><Esc>T{i}", -- Text citation
            ["<leader>fc"] = "\\footcite{}<++><Esc>T{i}", -- Footnote citation
            ["<leader>u"] = "\\usepackage{}<Esc>T{i}",     -- Insert package
            ["<leader>ig"] = "\\includegraphics[width=]{<++>}<Esc>T=i", -- Insert graphics
            ["<leader>fr"] = "\\begin{frame}{}<CR><++><CR>\\end{frame}<CR><++><Esc>4k$i", -- Frame for Beamer
            ["<leader>bl"] = "\\begin{block}{}<CR><++><CR>\\end{block}<CR><++><Esc>3k$i", -- Block for theorem/definition
            ["<leader>en"] = "\\begin{enumerate}<CR><CR>\\end{enumerate}<CR><++><Esc>2ki", -- Enumerate list
            ["<leader>it"] = "\\begin{itemize}<CR><CR>\\end{itemize}<CR><++><Esc>2ki\\item<Space>", -- Itemize list
            ["<leader>ce"] = "\\begin{center}<CR><CR>\\end{center}<CR><++><Esc>2ki", -- Center environment
            ["<leader>ta"] = "\\begin{tabular}{}<CR><++><CR>\\end{tabular}<CR><++><Esc>3k$i", -- Table environment
            ["<leader>ii"] = "<CR>\\item<Space>",  -- New list item
            ["<leader>-"] = "<Esc>\"zdiWi\\<C-R>z{}<++><Esc>T{i}", -- Autocomplete bracket/command
            ["<leader>."] = "<Esc>\"zdiWi\\begin{<C-R>z}<CR><CR>\\end{<C-R>z}<CR><++><Esc>2ki", -- Autocomplete LaTeX environment
        }

        -- Set all snippets in insert mode
        for k, v in pairs(snippet_mappings) do
            vim.keymap.set("i", k, v, { buffer = true })
        end
    end
})



-- [[ Python ]]
vim.api.nvim_create_augroup("PythonCommands", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = "PythonCommands",
    pattern = "python",
    callback = function()
        -- Set ruff as default linter
        vim.cmd("compiler ruff")

        -- Set a breakpoint in Python code using pdb
        vim.keymap.set("n", "<leader>b", "<Esc>oimport pdb; pdb.set_trace()<Esc>", { buffer = true, desc = "Insert breakpoint (pdb)" })

        -- Create custom commands for different Python tools
        vim.cmd("command! RuffCheck compiler ruff | normal <leader>mf")
        vim.cmd("command! RuffFmt !ruff format --line-length 79 %")
        vim.cmd("command! RuffImpFix !ruff check --select I --fix %")
        vim.cmd("command! RuffAllFix !ruff check --select I --fix % && ruff format --line-length 79 %")
        vim.cmd("command! Pylint compiler pylint | normal <leader>mf")
    end
})



-- [[ HTML ]]

vim.api.nvim_create_augroup("HtmlCommands", { clear = true })

-- Enable htmljinja syntax for HTML files
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = "HtmlCommands",
    pattern = "*.html",
    command = "set syntax=htmljinja"
})

-- Snippet to wrap a selected word with angle brackets (e.g., <div></div>)
vim.api.nvim_create_autocmd("FileType", {
    group = "HtmlCommands",
    pattern = {"html", "htmldjango"},
    callback = function()
        vim.keymap.set("i", "<leader>.", "<Esc>\"zdiWi<<C-R>z><CR><CR></<C-R>z><CR><++><Esc>2ki<Tab>", { buffer = true, desc = "Wrap word with HTML tags" })
    end
})



-- [[ C/C++ ]]

vim.api.nvim_create_augroup("CppCommands", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = "CppCommands",
    pattern = {"c", "cpp"},
    callback = function()
        -- Key mappings to quickly edit corresponding header/source files
        vim.keymap.set("n", "<Leader>oh", ":e %<.h<CR>", { buffer = true, desc = "Open header file (.h)" })
        vim.keymap.set("n", "<Leader>oc", ":e %<.c<CR>", { buffer = true, desc = "Open C source file (.c)" })
        vim.keymap.set("n", "<Leader>oc", ":e %<.cpp<CR>", { buffer = true, desc = "Open C++ source file (.cpp)" })

        -- Clean up build files (e.g., using make)
        vim.keymap.set("n", "<leader>mc", ":w<CR>:silent make clean | redraw! | cw<CR>", { buffer = true, desc = "Clean build files" })

        -- Define C/C++ snippets
        local cpp_snippets = {
            ["<leader>.b"] = "{<CR>}<Esc>O<Tab>", -- Block (e.g., for {} code)
            ["<leader>.r"] = "(<CR>)<Esc>O<Tab>", -- Function call (e.g., for arguments)
            ["<leader>.f"] = "for (; <++>; <++>)<CR>{<CR>}<Esc>O<Tab><++><Esc>kkF(a", -- For loop
            ["<leader>.w"] = "while ()<CR>{<CR>}<Esc>O<Tab><++><Esc>kk$i", -- While loop
            ["<leader>.c"] = "class <CR>{<CR>private:<CR><Tab><++><CR><BS>public:<CR><Tab><++><CR><BS>};<Esc>6kA", -- Class definition
            ["<leader>.s"] = "struct <CR>{<CR><Tab><++><CR><BS>};<Esc>3kA", -- Struct definition
            ["<leader>.i"] = "if ()<CR>{<CR>}<Esc>O<Tab><++><Esc>kk$i", -- If statement
            ["<leader>.e"] = "else<CR>{<CR>}<Esc>O<Tab>", -- Else statement
            ["<leader>.el"] = "else<CR>{<CR>}<Esc>O<Tab>", -- Else statement
            ["<leader>.ei"] = "else if ()<CR>{<CR>}<Esc>O<Tab><++><Esc>kk$i", -- Else if statement
            ["<leader>.o"] = "std::cout << <Esc>A", -- Output (e.g., std::cout)
        }

        -- Set C/C++ snippets in insert and normal modes
        for k, v in pairs(cpp_snippets) do
            vim.keymap.set({"i", "n"}, k, v, { buffer = true })
        end
    end
})



-- [[ Plugins ]]

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]

require("lazy").setup({

    { -- Comment / uncomment lines/blocks of code
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        }
    },

    { -- Modern statusline
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    section_separators = "",
                    component_separators = "",
                    icons_enabled = false,
                },
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = {"branch", "diff"},
                    lualine_c = {"filename"},
                    lualine_x = {"encoding", "fileformat", "filetype"},
                    lualine_y = {"progress"},
                    lualine_z = {"location"}
                }
            })
        end
    },

    { -- monokai colorscheme
        "loctvl842/monokai-pro.nvim",
    },

    { -- Fast fuzzy finder
        "ibhagwan/fzf-lua",
    },
})



-- [[ Settings After Plugins are Loaded ]]

-- Set colorscheme
local ok, _ = pcall(vim.cmd, "colorscheme monokai-pro-spectrum")
if not ok then
    vim.cmd("colorscheme desert")
end
