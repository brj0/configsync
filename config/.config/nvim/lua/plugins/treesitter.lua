return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "csv",
                "html",
                "javascript",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "rust",
                "vim",
                "vimdoc",
            },
            sync_install = false,
            highlight = { enable = true },
            indent = {
                enable = false,
            },
        })

        -- Prevent over-indentation in Python
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function()
                vim.bo.indentexpr = ""
            end,
        })

    end
}
