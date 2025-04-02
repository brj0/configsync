return {

    -- Essential Git plugin
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
    },

    -- Comment / uncomment lines/blocks of code
    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        opts = {
            -- add any options here
        }
    },

    -- Add/delete/change surrounding pairs
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    -- Highlight todo, notes, etc in comments:
    -- TODO:
    -- NOTE:
    -- WARNING:
    -- BUG:
    {
        'folke/todo-comments.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },

    -- Navigating undo history
    {
        "mbbill/undotree",
        event = "VeryLazy",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
        },
    },

    -- Change Files with sudo permissions
    {
        "lambdalisue/vim-suda",
        event = "VeryLazy",
    },

}
