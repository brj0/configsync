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

    -- Start intro dashboard
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            -- Get Neovim version using vim.version()
            local version = vim.version()
            local nvim_version = string.format(
                "NVIM v%d.%d.%d",
                version.major,
                version.minor,
                version.patch
            )
            local datetime = os.date("  %A, %B %d    %H:%M")

            require("dashboard").setup({
                theme = "doom",
                config = {
                    header = {
                        "",
                        "                         _           ",
                        "                        (_)          ",
                        "   _ __   ___  _____   ___ _ __ ___  ",
                        "  | '_ \\ / _ \\/ _ \\ \\ / / | '_ ` _ \\ ",
                        "  | | | |  __/ (_) \\ V /| | | | | | |",
                        "  |_| |_|\\___|\\___/ \\_/ |_|_| |_| |_|",
                        "",
                        "",
                        nvim_version,
                        "",
                    },
                    center = {
                        { icon = "  ", desc = " Find File", key = "f", action = "FzfLua files" },
                        { icon = "  ", desc = " Recent Files", key = "r", action = "FzfLua oldfiles" },
                        { icon = "  ", desc = " New File", key = "n", action = "enew" },
                        { icon = "⏻  ", desc = " Quit", key = "q", action = "qa" },
                    },
                    footer = { datetime },
                },
            })
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },

}
