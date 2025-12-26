return {

    -- LSP
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            vim.lsp.config.ruff = {
                autostart = false,
            }

            _G.toggle_lsp = function()
                local clients = vim.lsp.get_clients({ name = "ruff" })

                if #clients > 0 then
                    -- Disable ruff LSP
                    vim.cmd("LspStop")  -- Stop all LSP servers
                    vim.notify("LSP Disabled", vim.log.levels.INFO)
                else
                    -- Enable ruff LSP
                    vim.lsp.enable("ruff")

                    vim.notify("LSP Enabled", vim.log.levels.INFO)
                end
            end

            -- Keybinding
            vim.keymap.set(
                "n",
                "<leader>L",
                toggle_lsp,
                { noremap = true, silent = true, desc = "Toggle Ruff LSP" }
            )
        end,
    },

}
