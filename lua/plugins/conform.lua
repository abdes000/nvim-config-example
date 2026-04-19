return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            -- Map of filetype to formatters
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                go = { "goimports", "gofmt" },
                -- You can also customize some of the format options for the filetype
                rust = { "rustfmt", lsp_format = "fallback" },
                -- You can use a function here to determine the formatters dynamically
                python = function(bufnr)
                    if require("conform").get_formatter_info("ruff_format", bufnr).available then
                        return { "ruff_format" }
                    else
                        return { "isort", "black" }
                    end
                end,
                -- Use the "*" filetype to run formatters on all filetypes.
                ["*"] = { "codespell" },
                -- Use the "_" filetype to run formatters on filetypes that don't
                -- have other formatters configured.
                ["_"] = { "trim_whitespace" },
            },
            -- Set this to change the default values when calling conform.format()
            -- This will also affect the default values for format_on_save/format_after_save
            default_format_opts = {
                lsp_format = "fallback",
            },
            -- If this is set, Conform will run the formatter on save.
            -- It will pass the table to conform.format().
            -- This can also be a function that returns the table.
            format_on_save = {
                -- I recommend these options. See :help conform.format for details.
                lsp_format = "fallback",
                timeout_ms = 500,
            },
            -- If this is set, Conform will run the formatter asynchronously after save.
            -- It will pass the table to conform.format().
            -- This can also be a function that returns the table.
            format_after_save = {
                lsp_format = "fallback",
            },
            -- Set the log level. Use `:ConformInfo` to see the location of the log file.
            log_level = vim.log.levels.ERROR,
            -- Conform will notify you when a formatter errors
            notify_on_error = true,
            -- Conform will notify you when no formatters are available for the buffer
            notify_no_formatters = true,
            -- Custom formatters and overrides for built-in formatters
            formatters = {
                my_formatter = {
                    -- This can be a string or a function that returns a string.
                    -- When defining a new formatter, this is the only field that is required
                    command = "my_cmd",
                    -- A list of strings, or a function that returns a list of strings
                    -- Return a single string instead of a list to run the command in a shell
                    args = { "--stdin-from-filename", "$FILENAME" },
                    -- If the formatter supports range formatting, create the range arguments here
                    range_args = function(self, ctx)
                        return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
                    end,
                    -- Send file contents to stdin, read new contents from stdout (default true)
                    -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
                    -- file is assumed to be modified in-place by the format command.
                    stdin = true,
                    -- A function that calculates the directory to run the command in
                    cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
                    -- When cwd is not found, don't run the formatter (default false)
                    require_cwd = true,
                    -- When stdin=false, use this template to generate the temporary file that gets formatted
                    tmpfile_format = ".conform.$RANDOM.$FILENAME",
                    -- When returns false, the formatter will not be used
                    condition = function(self, ctx)
                        return vim.fs.basename(ctx.filename) ~= "README.md"
                    end,
                    -- Exit codes that indicate success (default { 0 })
                    exit_codes = { 0, 1 },
                    -- Environment variables. This can also be a function that returns a table.
                    env = {
                        VAR = "value",
                    },
                    -- Set to false to disable merging the config with the base definition.
                    -- Can also be set to the name of the formatter to merge with (e.g. inherit = "black")
                    inherit = true,
                    -- When inherit = true, add these additional arguments to the beginning of the command.
                    -- This can also be a function, like args
                    prepend_args = { "--use-tabs" },
                    -- When inherit = true, add these additional arguments to the end of the command.
                    -- This can also be a function, like args
                    append_args = { "--trailing-comma" },
                },
                -- These can also be a function that returns the formatter
                other_formatter = function(bufnr)
                    return {
                        command = "my_cmd",
                    }
                end,
            },
        })

        -- You can set formatters_by_ft and formatters directly
        require("conform").formatters_by_ft.lua = { "stylua" }
        require("conform").formatters.my_formatter = {
            command = "my_cmd",
        }

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })

        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"


        local M = {}

        M.setup = function()
            local conform = require("conform")

            conform.setup({
                -- Map filetypes to formatters
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                },

                -- Global options
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },

                -- Formatter-specific options
                formatters = {
                    stylua = { prepend_args = { "--indent-type", "Spaces" } },
                    black = { prepend_args = { "--line-length", "88" } },
                    prettier = { prepend_args = { "--tab-width", "2" } },
                },
            })

            -- Autocommand: format before save
            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function(args)
                    conform.format({ bufnr = args.buf })
                end,
            })

            -- Autocommand: install formatter on-demand when file is opened
            vim.api.nvim_create_autocmd("BufReadPost", {
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    local formatters = conform.list_formatters(ft)
                    for _, f in ipairs(formatters) do
                        -- Use Mason to install missing formatter
                        local ok, mason_registry = pcall(require, "mason-registry")
                        if ok and not mason_registry.is_installed(f) then
                            vim.notify("Installing formatter: " .. f)
                            mason_registry.get_package(f):install()
                        end
                    end
                end,
            })
        end

        return M
    end
}
