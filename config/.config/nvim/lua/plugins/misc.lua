return {

    -- Comment / uncomment lines/blocks of code
    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        opts = {
            -- add any options here
        }
    },

    -- Highlight todo, notes, etc in comments
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },

    -- Navigating undo history
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
        },
    },
}
