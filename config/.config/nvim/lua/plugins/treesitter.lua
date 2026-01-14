return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
        local configs = require("nvim-treesitter.config")

        configs.setup({
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "csv",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "rust",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })

    end
}
