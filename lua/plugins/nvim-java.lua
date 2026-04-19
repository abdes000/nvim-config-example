return {
    'nvim-java/nvim-java',
    config = function()
        require('java').setup({
            -- Startup checks
            checks = {
                nvim_version = true,        -- Check Neovim version
                nvim_jdtls_conflict = true, -- Check for nvim-jdtls conflict
            },

            -- JDTLS configuration
            jdtls = {
                version = '1.43.0',
            },

            -- Extensions
            lombok = {
                enable = true,
                version = '1.18.40',
            },

            java_test = {
                enable = true,
                version = '0.40.1',
            },

            java_debug_adapter = {
                enable = true,
                version = '0.58.2',
            },

            spring_boot_tools = {
                enable = true,
                version = '1.55.1',
            },

            -- JDK installation
            jdk = {
                auto_install = true,
                version = '17',
            },

            -- Logging
            log = {
                use_console = true,
                use_file = true,
                level = 'info',
                log_file = vim.fn.stdpath('state') .. '/nvim-java.log',
                max_lines = 1000,
                show_location = false,
            },
        })
        vim.lsp.enable('jdtls')
        vim.lsp.config('jdtls', {
            settings = {
                java = {
                    configuration = {
                        runtimes = {
                            {
                                name = "JavaSE-21",
                                path = "/opt/jdk-21",
                                default = true,
                            }
                        }
                    }
                }
            }
        })

        -- Helper for shorter keymap calls
        local opts = { noremap = true, silent = true }
        local keymap = vim.keymap.set

        -- JDTLS organize imports
        keymap("n", "<A-o>", function()
            require("jdtls").organize_imports()
        end, opts)

        -- Extract variable
        keymap("n", "crv", function()
            require("jdtls").extract_variable()
        end, opts)

        keymap("v", "crv", function()
            require("jdtls").extract_variable(true)
        end, opts)

        -- Extract constant
        keymap("n", "crc", function()
            require("jdtls").extract_constant()
        end, opts)

        keymap("v", "crc", function()
            require("jdtls").extract_constant(true)
        end, opts)

        -- Extract method
        keymap("v", "crm", function()
            require("jdtls").extract_method(true)
        end, opts)

        -- If using nvim-dap with java-debug + vscode-java-test
        keymap("n", "<leader>df", function()
            require("jdtls").test_class()
        end, opts)

        keymap("n", "<leader>dn", function()
            require("jdtls").test_nearest_method()
        end, opts)
    end,
}
