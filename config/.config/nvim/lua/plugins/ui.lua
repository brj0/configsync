return {

    -- Modern statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    section_separators = "",
                    component_separators = "",
                    icons_enabled = false,
                },
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = {"branch", "diff"},
                    lualine_c = {"filename"},
                    lualine_x = {"encoding", "fileformat", "filetype"},
                    lualine_y = {"progress"},
                    lualine_z = {"location"}
                }
            })
        end
    },

    { -- monokai colorscheme
        "loctvl842/monokai-pro.nvim",
        config = function()
            require("monokai-pro").setup({
                override = function(c) -- Override specific colors
                    return {
                        QuickFixLine = { bg = c.base.dimmed3, fg = c.base.white, bold = true }, -- Selected QuickFix line
                        Directory = { bg = "NONE", fg = c.base.cyan, bold = true }, -- Directories in netrw and non-selected QuickFix lines
                    }
                end
            })
            vim.cmd("colorscheme monokai-pro-spectrum")
        end
    },

    { -- monokai colorscheme - faster than pro version
        "polirritmico/monokai-nightasty.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd("colorscheme monokai-nightasty")
        end
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
