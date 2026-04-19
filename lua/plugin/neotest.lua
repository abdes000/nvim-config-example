return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        -- init.lua or plugin config
        require("neotest").setup(
            {
                adapters = {
                    require("neotest-python")(
                        {
                            dap = {justMyCode = false},
                            runner = "pytest"
                        }
                    ),
                    require("neotest-jest")(
                        {
                            jestCommand = "npm test --",
                            jestConfigFile = "jest.config.js",
                            env = {CI = true},
                            cwd = function(path)
                                return vim.fn.getcwd()
                            end
                        }
                    ),
                    require("neotest-go")(
                        {
                            args = {"-count=1", "-timeout=60s"}
                        }
                    ),
                    require("neotest-plenary"),
                    require("neotest-vim-test")(
                        {
                            ignore_file_types = {"python", "javascript", "typescript", "go"}
                        }
                    )
                },
                quickfix = {
                    enabled = true,
                    open = false
                },
                output = {
                    enabled = true,
                    open_on_run = "short"
                },
                status = {
                    enabled = true,
                    signs = true,
                    virtual_text = true
                },
                diagnostic = {
                    enabled = true,
                    severity = vim.diagnostic.severity.ERROR
                }
            }
        )
        require("neotest").setup(
            {
                adapters = {
                    -- Python
                    require("neotest-python")({runner = "pytest"}), -- also supports unittest
                    -- Lua
                    require("neotest-plenary"),
                    require("neotest-busted"),
                    -- Go
                    require("neotest-go"),
                    require("neotest-golang"),
                    -- JavaScript / TypeScript
                    require("neotest-jest"),
                    require("neotest-mocha"),
                    require("neotest-vitest"),
                    require("neotest-bun"),
                    require("neotest-stenciljs"),
                    require("neotest-playwright"),
                    -- Ruby
                    require("neotest-rspec"),
                    require("neotest-minitest"),
                    require("neotest-ruby-minitest"),
                    -- Dart / Flutter
                    require("neotest-dart"),
                    -- R
                    require("neotest-testthat"),
                    -- PHP
                    require("neotest-phpunit"),
                    require("neotest-pest"),
                    -- Rust
                    require("neotest-rust"),
                    require("rustaceanvim"), -- LSP-based runner
                    -- Elixir
                    require("neotest-elixir"),
                    -- .NET
                    require("neotest-dotnet"),
                    require("neotest-vstest"),
                    -- Scala
                    require("neotest-scala"),
                    -- Haskell
                    require("neotest-haskell"),
                    -- Deno
                    require("neotest-deno"),
                    -- Java / Kotlin
                    require("neotest-java"),
                    require("neotest-kotlin"),
                    -- Solidity
                    require("neotest-foundry"),
                    require("neotest-hardhat"),
                    -- Zig
                    require("neotest-zig"),
                    -- C++
                    require("neotest-gtest"),
                    require("neotest-ctest"),
                    -- Build systems
                    require("neotest-gradle"),
                    require("neotest-bazel"),
                    -- Bash
                    require("neotest-bash"),
                    -- Swift
                    require("neotest-swift-testing")
                },
                quickfix = {enabled = true, open = false},
                output = {enabled = true, open_on_run = "short"},
                status = {enabled = true, signs = true, virtual_text = true},
                diagnostic = {enabled = true, severity = vim.diagnostic.severity.ERROR}
            }
        )
        local opts = {noremap = true, silent = true}

        local keys = {
            {
                "<leader>tn",
                function()
                    require("neotest").run.run()
                end,
                desc = "Run nearest test"
            },
            {
                "<leader>tf",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                desc = "Run tests in current file"
            },
            {
                "<leader>td",
                function()
                    require("neotest").run.run({strategy = "dap"})
                end,
                desc = "Debug nearest test"
            },
            {
                "<leader>ts",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "Toggle test summary"
            },
            {
                "<leader>to",
                function()
                    require("neotest").output.open({enter = true})
                end,
                desc = "Open test output"
            },
            {
                "<leader>tp",
                function()
                    require("neotest").output_panel.toggle()
                end,
                desc = "Toggle output panel"
            },
            {
                "<leader>tw",
                function()
                    require("neotest").watch.toggle(vim.fn.expand("%"))
                end,
                desc = "Toggle watch on file"
            },
            {
                "<leader>tn",
                function()
                    require("neotest").run.run()
                end,
                desc = "Run nearest test"
            },
            {
                "<leader>tf",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                desc = "Run tests in current file"
            },
            {
                "<leader>ta",
                function()
                    require("neotest").run.run(vim.fn.getcwd())
                end,
                desc = "Run all tests in project"
            },
            {
                "<leader>td",
                function()
                    require("neotest").run.run({strategy = "dap"})
                end,
                desc = "Debug nearest test"
            },
            {
                "<leader>ts",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "Toggle test summary"
            },
            {
                "<leader>to",
                function()
                    require("neotest").output.open({enter = true})
                end,
                desc = "Open test output"
            },
            {
                "<leader>tp",
                function()
                    require("neotest").output_panel.toggle()
                end,
                desc = "Toggle output panel"
            },
            {
                "<leader>tw",
                function()
                    require("neotest").watch.toggle(vim.fn.expand("%"))
                end,
                desc = "Toggle watch on file"
            }
        }

        for _, key in ipairs(keys) do
            vim.keymap.set("n", key[1], key[2], opts)
        end

        -- Automatically run tests on save for certain filetypes
        vim.api.nvim_create_autocmd(
            "BufWritePost",
            {
                pattern = {"*.py", "*.js", "*.ts", "*.go"},
                callback = function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end
            }
        )
        -- Auto-run tests on save for supported filetypes
        vim.api.nvim_create_autocmd(
            "BufWritePost",
            {
                pattern = {
                    "*.py",
                    "*.js",
                    "*.ts",
                    "*.go",
                    "*.rs",
                    "*.rb",
                    "*.php",
                    "*.dart",
                    "*.scala",
                    "*.hs",
                    "*.java",
                    "*.kt",
                    "*.zig",
                    "*.cpp",
                    "*.c",
                    "*.sh",
                    "*.swift"
                },
                callback = function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end
            }
        )
    end
}
