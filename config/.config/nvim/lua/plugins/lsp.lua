return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            -- 1. Mason Setup
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = { 'ruff', 'lua_ls' }
            })

            -- 2. Configure Ruff
            vim.lsp.config.ruff = { autostart = false }
            vim.lsp.enable("ruff", false)

            -- 3. Configure Lua (with Root Detection & Neovim Support)
            vim.lsp.config.lua_ls = {
                autostart = false,
                -- This fixes the "Root directory: nil" issue
                root_dir = vim.fs.root(0, { ".git", "init.lua", ".luarc.json" }),
                settings = {
                    Lua = {
                        diagnostics = {
                            -- Recognizes the 'vim' global variable
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Makes the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            }
            vim.lsp.enable("lua_ls", false)

            -- 4. Toggle Logic
            -- This checks if LSP is running: if yes, stops it; if no, starts it.
            local function toggle_lsp()
                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr })
                local servers = { 'ruff', 'lua_ls' }

                if #clients > 0 then
                    for _, lsp in ipairs(servers) do
                        vim.lsp.enable(lsp, false)
                    end
  
                    vim.cmd("LspStop")
                    vim.notify("LSP Off", vim.log.levels.WARN, { title = "LSP" })
                else
                    for _, lsp in ipairs(servers) do
                        vim.lsp.enable(lsp, true)
                    end
 
                    vim.cmd("LspStart")
                    vim.notify("LSP On", vim.log.levels.INFO, { title = "LSP" })
                end
            end

            -- 5. Keymap: Toggle with Leader + Shift + L
            vim.keymap.set('n', '<leader>L', toggle_lsp, { desc = 'Toggle [L]SP' })
        end
    },

    -- {
    --     "neovim/nvim-lspconfig",
    --     dependencies = {
    --     "williamboman/mason-lspconfig.nvim",
    --     },
    --
    --     config = function()
    --     local lspconfig = require("lspconfig")
    --     local capabilities = vim.lsp.protocol.make_client_capabilities()
    --
    --     local on_attach = function(_, bufnr)
    --         local map = function(mode, lhs, rhs)
    --         vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
    --         end
    --
    --         map("n", "gd", vim.lsp.buf.definition)
    --         map("n", "gr", vim.lsp.buf.references)
    --         map("n", "K", vim.lsp.buf.hover)
    --         map("n", "<leader>rn", vim.lsp.buf.rename)
    --         map("n", "<leader>ca", vim.lsp.buf.code_action)
    --     end
    --
    --     -- =====================
    --     -- PYRIGHT
    --     -- =====================
    --     lspconfig.pyright.setup({
    --         on_attach = on_attach,
    --         capabilities = capabilities,
    --         settings = {
    --         python = {
    --             analysis = {
    --             typeCheckingMode = "basic",
    --             },
    --         },
    --         },
    --     })
    --
    --     -- =====================
    --     -- RUFF
    --     -- =====================
    --     lspconfig.ruff.setup({
    --         on_attach = function(client, bufnr)
    --         -- Let Pyright handle hover
    --         client.server_capabilities.hoverProvider = false
    --         on_attach(client, bufnr)
    --         end,
    --         capabilities = capabilities,
    --     })
    --
    --     -- =====================
    --     -- LUA (lazydev compatible)
    --     -- =====================
    --     lspconfig.lua_ls.setup({
    --         on_attach = on_attach,
    --         capabilities = capabilities,
    --         settings = {
    --         Lua = {
    --             completion = { callSnippet = "Replace" },
    --         },
    --         },
    --     })
    --
    --     -- =====================
    --     -- LSP TOGGLE
    --     -- =====================
    --     local lsp_enabled = true
    --
    --     vim.keymap.set("n", "<leader>L", function()
    --         lsp_enabled = not lsp_enabled
    --
    --         if not lsp_enabled then
    --         for _, client in pairs(vim.lsp.get_active_clients()) do
    --             client.stop()
    --         end
    --         vim.notify("LSP disabled", vim.log.levels.WARN)
    --         else
    --         vim.cmd("doautocmd FileType")
    --         vim.notify("LSP enabled", vim.log.levels.INFO)
    --         end
    --     end, { desc = "Toggle LSP" })
    --     end,
    -- },

}
