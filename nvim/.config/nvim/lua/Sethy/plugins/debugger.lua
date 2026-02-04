return {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function ()
            local mason_dap = require("mason-nvim-dap")
            local dap = require("dap")
            local ui = require("dapui")
            local dap_virtual_text = require("nvim-dap-virtual-text")

            -- Dap Virtual Text
            dap_virtual_text.setup()

            mason_dap.setup({
                ensure_installed = { "cppdbg", "python" },
                automatic_installation = true,
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
            })

            -- Configurations
            dap.configurations = {
                c = {
                    {
                        name = "Launch file",
                        type = "cppdbg",
                        request = "launch",
                        program = function()
                            return vim.fn.input(
                                "Path to executable: ",
                                vim.fn.getcwd() .. "/",
                                "file"
                            )
                        end,
                        cwd = "${workspaceFolder}",
                        stopAtEntry = false,
                        -- MIMode = "lldb", -- doesn't work on Fedora linux, on Mac there shouldn't be a problem.
                        MIMode = "gdb", -- ensure is installed (in Fedora sudo dnf install gdb)
                        miDebuggerPath = "/usr/bin/gdb",
                    },
                    {
                        name = "Attach to lldbserver :1234",
                        type = "cppdbg",
                        request = "launch",
                        MIMode = "lldb",
                        miDebuggerServerAddress = "localhost:1234",
                        miDebuggerPath = "/usr/bin/lldb",
                        cwd = "${workspaceFolder}",
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                    },
                },
                python = {
                    {
                        -- The first three options are required by nvim-dap
                        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
                        request = "launch",
                        name = "Launch file",

                        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                        program = "${file}", -- This configuration will launch the current file if used.
                        pythonPath = function()
                            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                            local cwd = vim.fn.getcwd()
                            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                                return cwd .. "/venv/bin/python"
                            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                                return cwd .. "/.venv/bin/python"
                            else
                                return "/usr/bin/python"
                            end
                        end,
                    },
                },
            }

            -- Dap UI
            ui.setup()

            vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end

            -- Keybindings
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, opts)
            vim.keymap.set("n", "<leader>dc", dap.continue, opts)
            vim.keymap.set("n", "<leader>di", dap.step_into, opts)
            vim.keymap.set("n", "<leader>do", dap.step_over, opts)
            vim.keymap.set("n", "<leader>du", dap.step_out, opts)
            vim.keymap.set("n", "<leader>dr", dap.repl.open, opts)
            vim.keymap.set("n", "<leader>dl", dap.run_last, opts)

            vim.keymap.set("n", "<leader>dq", function()
                dap.terminate()
                ui.close()
                dap_virtual_text.toggle()
            end, opts)

            vim.keymap.set("n", "<leader>db", dap.list_breakpoints, opts)

            vim.keymap.set("n", "<leader>de", function()
                dap.set_exception_breakpoints({ "all" })
            end, opts)
        end
    },

}
