return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("fzf-lua").setup({
            files = {
                hidden = true, -- enable hidden files by default
                follow = true, -- do follow symlinks
            },
            grep = {
                hidden = true,
            },
        })

        -- Mapping for fzf commands
        local fzf = require("fzf-lua")
        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<leader>sf", fzf.files, opts)
        vim.keymap.set("n", "<leader>sg", fzf.live_grep, opts)
        vim.keymap.set("n", "<leader>sb", fzf.buffers, opts)
        vim.keymap.set("n", "<leader>sh", fzf.help_tags, opts)
        vim.keymap.set("n", "<leader>sm", fzf.man_pages, opts)
        vim.keymap.set("n", "<leader>sr", fzf.lsp_references, opts)
        vim.keymap.set("n", "<leader>sd", fzf.lsp_definitions, opts)
        vim.keymap.set("n", "<leader>s*", fzf.grep_cword, opts)

        vim.keymap.set("n", "<leader>sF", function()
            fzf.files({ no_ignore = true })
        end, opts)

        vim.keymap.set("n", "<leader>sG", function()
            fzf.live_grep({ no_ignore = true })
        end, opts)

        vim.keymap.set("v", "<leader>s*", function()
            vim.cmd('normal! "zy')
            local text = vim.fn.getreg("z")
            fzf.live_grep({ query = text })
        end, opts)
    end,
}
