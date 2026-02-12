return {

    -- Essential Git plugin
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
    },

    -- Comment / uncomment lines/blocks of code
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
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
        end,
    },

    -- Show CSS Colors
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },

    -- Highlight todo, notes, etc in comments:
    -- TODO:
    -- NOTE:
    -- WARNING:
    -- BUG:
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
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

    -- Highlight Snakefiles
    {
        "snakemake/snakemake",
        ft = "snakemake",
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/misc/vim")

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "snakemake",
                callback = function()
                    vim.opt_local.foldenable = false
                end,
            })
        end,
        init = function(plugin)
            require("lazy.core.loader").ftdetect(plugin.dir .. "/misc/vim")
        end,
    },

    -- File browser
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        lazy = false,
    },

    {
        "hat0uma/csvview.nvim",
        opts = {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
        keys = {
            {
                "<leader>c",
                function()
                    if vim.b.csvview_info then
                        vim.cmd("CsvViewToggle")
                        vim.wo.wrap = true
                    else
                        vim.cmd("CsvViewToggle")
                    end
                end,
                desc = "CSV: Toggle view (+wrap handling)",
                mode = "n",
            },
        },
    },
}
