-- Open the Neovim config directory in the current window
vim.api.nvim_create_user_command("OpenConfig", function()
    vim.cmd("edit ~/.config/nvim") -- Open in the current window
end, { desc = "Open Neovim config directory in the current window" })

-- Show all highlighting colors
vim.api.nvim_create_user_command(
    "Hitest",
    "source $VIMRUNTIME/syntax/hitest.vim",
    {}
)

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
