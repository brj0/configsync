return {

    {
        "mason-org/mason.nvim",
        opts = {},
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                -- 'pyright',
                "ruff",
                "texlab",
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
            vim.keymap.set("n", "<leader>ld", function()
                local enabled = not vim.diagnostic.is_enabled()
                vim.diagnostic.enable(enabled)
                print(enabled and "LSP Diagnostics ON" or "LSP Diagnostics OFF")
            end, { desc = "Toggle diagnostics" })

            -- Lua
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
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
            vim.keymap.set("n", "<leader>ll", function()
                vim.lsp.enable("lua_ls")
                print("Lua LSP started")
            end)

            -- Python
            vim.keymap.set("n", "<leader>lr", function()
                vim.lsp.enable("ruff")
                print("Ruff LSP started")
            end)

            -- vim.lsp.enable("pyright")

            -- LaTeX (TexLab LSP)
            vim.lsp.config("texlab", {
                capabilities = capabilities,
                settings = {
                    texlab = {
                        build = {
                            executable = "latexmk",
                            args = {
                                "-pdf",
                                "-interaction=nonstopmode",
                                "-synctex=1",
                                "%f",
                            },
                            onSave = false,
                            forwardSearchAfter = false,
                        },
                        forwardSearch = {
                            executable = "zathura",
                            args = { "--synctex-forward", "%l:%c:%f", "%p" },
                        },
                        lint = {
                            onChange = true,
                        },
                    },
                },
            })
            vim.keymap.set("n", "<leader>lt", function()
                vim.lsp.enable("texlab")
                print("Texlab LSP started")
            end)
        end,
    },
}
