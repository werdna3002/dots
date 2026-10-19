
return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "jay-babu/mason-nvim-dap.nvim",
            "mason-org/mason.nvim",
        },
        keys = {
            {
                "<F6>",
                function()
                    require("dap").continue()
                end,
                desc = "Debug: Start/Continue",
            },
            {
                "<F7>",
                function()
                    require("dap").step_over()
                end,
                desc = "Debug: Step over",
            },
            {
                "<F8>",
                function()
                    require("dap").step_into()
                end,
                desc = "Debug: Step into",
            },
            {
                "<F9>",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Debug: Toggle breakpoint",
            },
            {
                "<leader>du",
                function()
                    require("dapui").toggle()
                end,
                desc = "Debug: Toggle UI",
            },
            {
                "<leader>dx",
                function()
                    require("dap").terminate()
                    require("dapui").close()
                end,
                desc = "Debug: Stop",
            },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
dap.adapters.python = {
    type = "executable",
    command = "debugpy-adapter",
    args = {},
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch current Python file",
        program = "${file}",
        pythonPath = function()
            return vim.fn.exepath("python3")
        end,
        console = "integratedTerminal",
    },
}

            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] =
                function()
                    dapui.open()
                end

            dap.listeners.before.event_terminated["dapui_config"] =
                function()
                    dapui.close()
                end

            dap.listeners.before.event_exited["dapui_config"] =
                function()
                    dapui.close()
                end
        end,
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
            ensure_installed = { "python" },
            automatic_installation = false,
        },
    },
}

