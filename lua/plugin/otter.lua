return {
    'jmbuhr/otter.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
    config = function()
        local otter = require 'otter'
        otter.setup {
            lsp = {
                -- `:h events` that cause the diagnostics to update. Set to:
                -- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
                -- but more instant diagnostic updates
                diagnostic_update_events = { "BufWritePost" },
                -- function to find the root dir where the otter-ls is started
                root_dir = function(_, bufnr)
                    return vim.fs.root(bufnr or 0, {
                        ".git",
                        "_quarto.yml",
                        "package.json",
                    }) or vim.fn.getcwd(0)
                end,
            },
            -- options related to the otter buffers
            buffers = {
                -- if set to true, the filetype of the otterbuffers will be set.
                -- otherwise only the autocommand of lspconfig that attaches
                -- the language server will be executed without setting the filetype
                --- this setting is deprecated and will default to true in the future
                set_filetype = true,
                -- write <path>.otter.<embedded language extension> files
                -- to disk on save of main buffer.
                -- usefule for some linters that require actual files.
                -- otter files are deleted on quit or main buffer close
                write_to_disk = false,
                -- a table of preambles for each language. The key is the language and the value is a table of strings that will be written to the otter buffer starting on the first line.
                preambles = {},
                -- a table of postambles for each language. The key is the language and the value is a table of strings that will be written to the end of the otter buffer.
                postambles = {},
                -- A table of patterns to ignore for each language. The key is the language and the value is a lua match pattern to ignore.
                -- lua patterns: https://www.lua.org/pil/20.2.html
                ignore_pattern = {
                    -- ipython cell magic (lines starting with %) and shell commands (lines starting with !)
                    python = "^(%s*[%%!].*)",
                },
            },
            -- remove whitespace from the beginning of the code chunks when writing to the otter buffers
            -- and calculate it back in when handling lsp requests
            handle_leading_whitespace = true,
            -- mapping of filetypes to extensions for those not already included in otter.tools.extensions
            -- e.g. ["bash"] = "sh"
            extensions = {
            },
            -- add event listeners for LSP events for debugging
            debug = false,
            verbose = {               -- set to false to disable all verbose messages
                no_code_found = false -- warn if otter.activate is called, but no injected code was found
            },
        }
        --- Activate the current buffer by adding and synchronizing
        ---@param languages table|nil List of languages to activate. If nil, all available languages will be activated.
        ---@param completion boolean|nil Enable completion for otter buffers. Default: true
        ---@param diagnostics boolean|nil Enable diagnostics for otter buffers. Default: true
        ---@param tsquery string|nil Explicitly provide a treesitter query. If nil, the injections query for the current filetyepe will be used. See :h treesitter-language-injections.
        otter.activate(languages, completion, diagnostics, tsquery)

        local ms = vim.lsp.protocol.Methods
        local function get_otter_symbols_lang()
            local otterkeeper = require 'otter.keeper'
            local main_nr = vim.api.nvim_get_current_buf()
            local langs = {}
            for i, l in ipairs(otterkeeper.rafts[main_nr].languages) do
                langs[i] = i .. ': ' .. l
            end
            -- promt to choose one of langs
            local i = vim.fn.inputlist(langs)
            local lang = otterkeeper.rafts[main_nr].languages[i]
            local params = {
                textDocument = vim.lsp.util.make_text_document_params(),
                otter = {
                    lang = lang
                }
            }
            -- don't pass a handler, as we want otter to use its own handlers
            vim.lsp.buf_request(main_nr, ms.textDocument_documentSymbol, params, nil)
        end

        vim.keymap.set("n", "<leader>os", get_otter_symbols_lang, { desc = "otter [s]ymbols" })
    end
}
