return {

    -- LSP
    {
        "neovim/nvim-lspconfig",
        keys = {
            {
                "<leader>L",
                function()
                    _G.toggle_lsp()
                end,
                desc = "Toggle Ruff LSP",
            },
        },
        config = function()
            vim.lsp.config.ruff = {
                cmd = { "ruff", "server" },
                filetypes = { "python" },
                root_markers = { "pyproject.toml", ".git" },
                autostart = false,
            }

            _G.toggle_lsp = function()
                local clients = vim.lsp.get_clients({ name = "ruff" })

                if #clients > 0 then
                    for _, client in ipairs(clients) do
                        client.stop()
                    end
                    vim.notify("Ruff LSP disabled")
                else
                    vim.lsp.enable("ruff")
                    vim.notify("Ruff LSP enabled")
                end
            end
        end,
    },

}
