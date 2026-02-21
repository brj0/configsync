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
    vim.opt.clipboard = "unnamedplus"
end)

-- Enable mouse mode
vim.opt.mouse = "a"

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

-- Save undo history
-- vim.opt.undofile = true

-- Preview substitutions live, as we type
vim.opt.inccommand = "split"

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

-- Correct shiftwith in Python
vim.g.python_indent = {
    open_paren = "shiftwidth()",
    nested_paren = "shiftwidth()",
    continued = "shiftwidth()",
}

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Search down into subfolders
vim.opt.path:append("**")

-- Ctrl-x Ctrl-o completion
-- vim.opt.omnifunc = "syntaxcomplete#Complete"

-- Adjust timeouts
vim.opt.timeoutlen = 800
vim.opt.ttimeoutlen = 100

-- Disable automatic buffer hiding
vim.opt.hidden = false

-- Fallback colorscheme
vim.cmd("colorscheme slate")

-- Show LSP diagnostic
vim.diagnostic.config({
    virtual_text = {
        prefix = "■",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
})
