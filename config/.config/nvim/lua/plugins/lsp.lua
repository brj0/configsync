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
            "saghen/blink.cmp",
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
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                "${3rd}/luv/library",
                            },
                        },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            -- Python
            vim.lsp.enable("ruff")
            -- vim.lsp.enable("pyright")

        end
    },

}
