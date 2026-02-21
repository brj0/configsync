-- [[ Basic Autocommands ]]

-- Wrap text at the end of a word
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex", "markdown" },
    command = "setlocal linebreak",
})

-- Hack to make netrw wait for the tab shortcuts.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.keymap.set("n", "tt", "<Nop>", { noremap = true, buffer = true })
    end,
})

-- Use 2 spaces for certain file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "css",
        "html",
        "htmldjango",
        "javascript",
        "json",
        "markdown",
        "scss",
        "svelte",
        "toml",
        "typescript",
        "vue",
        "yaml",
    },
    command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})

-- Enable spell checking in specific file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex", "markdown", "html", "htmldjango" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us,de"
    end,
})

-- Auto-enable motion wrap for certain file types
local keymaps = require("core.keymaps")
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex", "markdown" },
    callback = function()
        if not wrap_keys_enabled then
            keymaps.toggle_motion_wrap()
        end
    end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Automatically close man pages with 'q'
vim.api.nvim_create_autocmd("FileType", {
    pattern = "man",
    callback = function()
        vim.keymap.set(
            "n",
            "q",
            "<cmd>quit<CR>",
            { buffer = true, silent = true, desc = "Close man page with 'q'" }
        )
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

local function TexBuild()
    vim.api.nvim_echo({ { "Compiling LaTeX…", "Normal" } }, false, {})
    vim.cmd("LspTexlabBuild")
    vim.defer_fn(function()
        vim.api.nvim_echo({}, false, {})
    end, 2000)
end

vim.api.nvim_create_autocmd("FileType", {
    group = "LatexCommands",
    pattern = "tex",
    callback = function()
        -- Use Texlab LSP compiler
        vim.keymap.set(
            "n",
            "<leader>bb",
            TexBuild,
            { desc = "TeX: Compile LaTeX", buffer = true, silent = true }
        )

        -- latexmk (automatic compilation tool)
        vim.cmd("compiler latexmk")

        -- pdflatex my_file.tex
        vim.keymap.set(
            "n",
            "<F2>",
            ":w<CR>:! pdflatex %<CR><CR>",
            { buffer = true, desc = "Compile LaTeX with pdflatex" }
        )

        -- biber my_file (for bibliography management)
        vim.keymap.set(
            "n",
            "<F4>",
            ":w<CR>:! biber %:r<CR><CR>",
            { buffer = true, desc = "Run biber for bibliography" }
        )

        -- Full command list (Biber: pdflatex -> biber -> pdflatex)
        vim.keymap.set("n", "<F5>", "<F2><F4><F2><F3>", {
            buffer = true,
            desc = "Full compilation (pdflatex -> biber -> pdflatex)",
        })

        -- Delete auxiliary files (log, aux, toc, bbl, ...) but keep the PDF
        vim.keymap.set(
            "n",
            "<leader>mc",
            ":cd %:p:h<CR>:!rm -f *.{aux,auxlock,bcf,bbl,blg,dvi,fdb_latexmk,fls,log,nav,out,rubbercache,snm,toc,vrb,xml}<CR><CR>",
            { buffer = true, desc = "Clean auxiliary files" }
        )

        -- Open generated PDF file
        vim.keymap.set(
            "n",
            "<F3>",
            ":! xdg-open %:r.pdf & disown<CR><CR>",
            { buffer = true, desc = "Open PDF with xdg-open" }
        )
        vim.keymap.set(
            "n",
            "<leader>mo",
            ":! xdg-open %:r.pdf & disown<CR><CR>",
            { buffer = true, desc = "Open PDF with xdg-open" }
        )
        vim.keymap.set(
            "n",
            "<leader>mz",
            ":! zathura %:r.pdf & disown<CR><CR>",
            { buffer = true, desc = "Open PDF with zathura" }
        )

        -- Define LaTeX snippets
        local snippet_mappings = {
            ["<leader>tb"] = "\\textbf{}<++><Esc>T{i}", -- Bold text
            ["<leader>ti"] = "\\textit{}<++><Esc>T{i}", -- Italic text
            ["<leader>tc"] = "\\textcite{}<++><Esc>T{i}", -- Text citation
            ["<leader>fc"] = "\\footcite{}<++><Esc>T{i}", -- Footnote citation
            ["<leader>u"] = "\\usepackage{}<Esc>T{i}", -- Insert package
            ["<leader>ig"] = "\\includegraphics[width=]{<++>}<Esc>T=i", -- Insert graphics
            ["<leader>fr"] = "\\begin{frame}{}<CR><++><CR>\\end{frame}<CR><++><Esc>4k$i", -- Frame for Beamer
            ["<leader>bl"] = "\\begin{block}{}<CR><++><CR>\\end{block}<CR><++><Esc>3k$i", -- Block for theorem/definition
            ["<leader>en"] = "\\begin{enumerate}<CR><CR>\\end{enumerate}<CR><++><Esc>2ki", -- Enumerate list
            ["<leader>it"] = "\\begin{itemize}<CR><CR>\\end{itemize}<CR><++><Esc>2ki\\item<Space>", -- Itemize list
            ["<leader>bc"] = "\\begin{center}<CR><CR>\\end{center}<CR><++><Esc>2ki", -- Center environment
            ["<leader>ta"] = "\\begin{tabular}{}<CR><++><CR>\\end{tabular}<CR><++><Esc>3k$i", -- Table environment
            ["<leader>ii"] = "<CR>\\item<Space>", -- New list item
            ["<leader>-"] = '<Esc>"zdiWi\\<C-R>z{}<++><Esc>T{i}', -- Autocomplete bracket/command
            ["<leader>."] = '<Esc>"zdiWi\\begin{<C-R>z}<CR><CR>\\end{<C-R>z}<CR><++><Esc>2ki', -- Autocomplete LaTeX environment
        }

        -- Set all snippets in insert mode
        for k, v in pairs(snippet_mappings) do
            vim.keymap.set("i", k, v, { buffer = true })
        end
    end,
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
        vim.keymap.set(
            "n",
            "<leader>b",
            "<Esc>oimport pdb; pdb.set_trace()<Esc>",
            { buffer = true, desc = "Insert breakpoint (pdb)" }
        )

        -- Create custom commands for different Python tools
        vim.cmd("command! RuffCheck compiler ruff | normal <leader>mf")
        vim.cmd("command! RuffFmt !ruff format --line-length 79 %")
        vim.cmd("command! RuffImpFix !ruff check --select I --fix %")
        vim.cmd(
            "command! RuffAllFix !ruff check --select I --fix % && ruff format --line-length 79 %"
        )
        vim.cmd("command! Pylint cexpr system('pylint ' .. expand('%')) | copen")
        vim.cmd(
            "command! PylintAll cexpr system('pylint $(find . -name \"*.py\")') | copen"
        )
        vim.cmd("command! Mypy cgete system('mypy ' .. expand('%')) | copen")
        vim.cmd("command! MypyAll cgete system('mypy .') | copen")

        vim.api.nvim_create_user_command("Ty", function()
            local output = vim.fn.system(
                "ty check " .. vim.fn.expand("%") .. " | sed 's/^[ ]*--> //g'"
            )
            vim.fn.setqflist(
                {},
                " ",
                { title = "Ty Check", lines = vim.split(output, "\n") }
            )
            vim.cmd("copen")
        end, {})

        vim.api.nvim_create_user_command("TyAll", function()
            local output = vim.fn.system("ty check . | sed 's/^[ ]*--> //g'")
            vim.fn.setqflist(
                {},
                " ",
                { title = "Ty Check All", lines = vim.split(output, "\n") }
            )
            vim.cmd("copen")
        end, {})
    end,
})

-- Join multi-line strings and format them properly
function FormatMultilineString()
    -- Get the selected lines in visual mode
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local selected_lines = vim.fn.getline(start_line, end_line)

    local full_content = table.concat(selected_lines, "")

    -- Remove internal quotes, and condense multiple spaces to a single space
    full_content = '"'
        .. full_content:gsub('"', ""):gsub("^%s*(.-)%s*$", "%1"):gsub("%s+", " ")
        .. '"'

    local max_line_width = 79
    local indentation = selected_lines[1]:match("^%s*")
    local effective_width = max_line_width - #indentation
    local result = {}
    local line = ""

    for word in full_content:gmatch("([^%s,]+[%s,]*)") do
        if #line + #word + 1 > effective_width then
            table.insert(result, indentation .. line .. '"')
            line = '"' .. word
        else
            line = line .. word
        end
    end

    if line ~= "" then
        table.insert(result, indentation .. line)
    end

    local original_lines = table.concat(selected_lines, "\n")
    local new_lines = table.concat(result, "\n")

    -- Only update the buffer if the lines have actually changed
    if original_lines ~= new_lines then
        vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, result)
    end
end

-- Format multi-line strings in the visual selection
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.keymap.set("v", "<Leader>Q", ":lua FormatMultilineString()<CR>", {
            buffer = true,
            noremap = true,
            silent = true,
            desc = "Format multiline Python string",
        })
    end,
})

-- [[ HTML ]]

vim.api.nvim_create_augroup("HtmlCommands", { clear = true })

-- Snippet to wrap a selected word with angle brackets (e.g., <div></div>)
vim.api.nvim_create_autocmd("FileType", {
    group = "HtmlCommands",
    pattern = { "html", "htmldjango" },
    callback = function()
        vim.keymap.set(
            "i",
            "<leader>.",
            '<Esc>"zdiWi<<C-R>z><CR><CR></<C-R>z><CR><++><Esc>2ki<Tab>',
            { buffer = true, desc = "Wrap word with HTML tags" }
        )
    end,
})

-- [[ C/C++ ]]

vim.api.nvim_create_augroup("CppCommands", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = "CppCommands",
    pattern = { "c", "cpp" },
    callback = function()
        -- Key mappings to quickly edit corresponding header/source files
        vim.keymap.set(
            "n",
            "<Leader>oh",
            ":e %<.h<CR>",
            { buffer = true, desc = "Open header file (.h)" }
        )
        vim.keymap.set(
            "n",
            "<Leader>oc",
            ":e %<.c<CR>",
            { buffer = true, desc = "Open C source file (.c)" }
        )
        vim.keymap.set(
            "n",
            "<Leader>oc",
            ":e %<.cpp<CR>",
            { buffer = true, desc = "Open C++ source file (.cpp)" }
        )

        -- Clean up build files (e.g., using make)
        vim.keymap.set(
            "n",
            "<leader>mc",
            ":w<CR>:silent make clean | redraw! | cw<CR>",
            { buffer = true, desc = "Clean build files" }
        )

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
            vim.keymap.set({ "i", "n" }, k, v, { buffer = true })
        end
    end,
})
