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

}
