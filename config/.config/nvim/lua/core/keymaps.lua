-- Set leader and local leader (plugins) keys
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ","
vim.g.maplocalleader = "<"

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
vim.keymap.set('n', '<leader>t', function()
    vim.cmd("30vsplit .")
end, { noremap = true, silent = true })

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

-- Replace all occurrences of the word under the cursor
vim.keymap.set("n", "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

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
