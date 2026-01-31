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
                no_ignore = true, -- don't respect ".gitignore"  by default
            },
        })

        -- Mapping for fzf commands
        vim.keymap.set(
            "n",
            "<leader>sf",
            "<cmd>lua require('fzf-lua').files()<CR>",
            { noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>sg",
            "<cmd>lua require('fzf-lua').live_grep()<CR>",
            { noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>sb",
            "<cmd>lua require('fzf-lua').buffers()<CR>",
            { noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>sh",
            "<cmd>lua require('fzf-lua').help_tags()<CR>",
            { noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>sm",
            "<cmd>lua require('fzf-lua').man_pages()<CR>",
            { noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>sr",
            "<cmd>lua require('fzf-lua').lsp_references()<CR>",
            { noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>sd",
            "<cmd>lua require('fzf-lua').lsp_definitions()<CR>",
            { noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>s*",
            "<cmd>lua require('fzf-lua').grep_cword()<CR>",
            { noremap = true, silent = true }
        )
    end,
}
