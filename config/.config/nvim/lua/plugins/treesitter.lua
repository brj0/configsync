return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "cpp", "css", "elixir", "heex", "html", "javascript", "lua", "python", "query", "rust", "vim", "vimdoc" },
            sync_install = false,
            highlight = { enable = true },
            indent = {
                enable = true,
                disable = { "python" },
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
