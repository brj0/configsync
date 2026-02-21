return {

    {
        "igorlfs/nvim-dap-view",
        dependencies = {
            "mfussenegger/nvim-dap",
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
        },
        keys = {
            { "<leader>dO", "<cmd>DapStepOut<cr>", desc = "Step Out" },
            { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Breakpoint" },
            { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
            { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into" },
            { "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step Over" },
            { "<leader>dt", "<cmd>DapViewToggle<cr>", desc = "Toggle View" },
            { "<leader>dw", "<cmd>DapViewWatch<cr>", desc = "Watch" },
            { "<leader>dq", "<cmd>DapTerminate<cr>", desc = "Quit Debug" },
        },
        config = function()
            local dap = require("dap")
            local dap_python = require("dap-python")

            -- Setup virtual text
            require("nvim-dap-virtual-text").setup()

            -- Detect project virtualenv automatically
            local function get_python_path()
                -- 1. Activated virtualenv
                if vim.env.VIRTUAL_ENV then
                    return vim.env.VIRTUAL_ENV .. "/bin/python"
                end

                -- 2. uv / local .venv
                local cwd = vim.fn.getcwd()
                if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                    return cwd .. "/.venv/bin/python"
                end

                -- 3. Fallback to system python
                return vim.fn.exepath("python3")
            end

            -- Setup Python adapter
            dap_python.setup(get_python_path())

            -- Explicit Python configuration
            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = get_python_path,
                },
            }
        end,
    },
}
