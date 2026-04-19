return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'TSUpdate',
            callback = function()
                require('nvim-treesitter.parsers').zimbu = {
                    install_info = {
                        url = 'https://github.com/zimbulang/tree-sitter-zimbu',
                        -- revision = <sha>, -- commit hash for revision to check out; HEAD if missing
                        -- optional entries:
                        branch = 'develop',         -- only needed if different from default branch
                        location = 'parser',        -- only needed if the parser is in subdirectory of a "monorepo"
                        generate = true,            -- only needed if repo does not contain pre-generated `src/parser.c`
                        generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
                        queries = 'queries/neovim', -- also install queries from given directory
                    },
                }
            end
        })
        -- treesitter.lua
        require("nvim-treesitter.configs").setup {
            -- Install all maintained parsers automatically
            ensure_installed = "all",

            -- Install missing parsers when entering buffer
            auto_install = true,

            highlight = {
                enable = true, -- Enable syntax highlighting
                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true, -- Enable indentation based on treesitter
            },
        }
    end
}
