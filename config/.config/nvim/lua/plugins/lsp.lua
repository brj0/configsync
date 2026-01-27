return {

    {
        "mason-org/mason.nvim",
        opts = {}
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                'lua_ls',
                -- 'pyright',
                'ruff',
            },
        },
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },


    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()

            -- Diagnostics OFF by default
            vim.diagnostic.enable(false)

            -- Toggle diagnostics
            vim.keymap.set("n", "<leader>d", function()
                local enabled = not vim.diagnostic.is_enabled()
                vim.diagnostic.enable(enabled)
                print(enabled and "Diagnostics ON" or "Diagnostics OFF")
            end, { desc = "Toggle diagnostics" })

            -- Lua
            vim.lsp.enable("lua_ls")

            -- Python
            vim.lsp.enable("ruff")
            -- vim.lsp.enable("pyright")

        end
    },

}
