return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Core
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",

            -- Snippets
            "crazyhulk/cmp-sign",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/cmp-luasnip-choice",
            "abeldekat/cmp-mini-snippets",
            "xzbdmw/cmp-mini-snippets",
            "notomo/cmp-neosnippet",
            "dcampos/cmp-snippy",
            "quangnguyen30192/cmp-nvim-ultisnips",
            "hrsh7th/cmp-vsnip",
            "kento-ogata/cmp-tsnip",

            -- Buffer / Vim builtins
            "rasulomaroff/cmp-bufname",
            "amarakon/nvim-cmp-buffer-lines",
            "hrsh7th/cmp-calc",
            "PhilRunninger/cmp-rpncalc",
            "uga-rosa/cmp-dictionary",
            "dmitmel/cmp-digraphs",
            "hrsh7th/cmp-omni",
            "f3fora/cmp-spell",

            -- LSP extras
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "dmitmel/cmp-vim-lsp",
            "JMarkin/cmp-diag-codes",
            "zjp-CN/nvim-cmp-lsp-rs",
            "samiulsami/cmp-go-deep",

            -- Paths
            "cmp-async-path",

            -- Git
            "petertriho/cmp-git",
            "davidsierradz/cmp-conventionalcommits",
            "Dosx001/cmp-commit",
            "Dynge/gitmoji.nvim",

            -- Command line
            "dmitmel/cmp-cmdline-history",
            "teramako/cmp-cmdline-prompt.nvim",

            -- Fuzzy
            "tzachar/cmp-fuzzy-buffer",
            "tzachar/cmp-fuzzy-path",
            "lukas-reineke/cmp-rg",

            -- Shell
            "mtoohey31/cmp-fish",
            "garyhurtz/cmp_kitty",
            "CharlesTaylor7/cmp-nushell-history",
            "andersevenrud/cmp-tmux",
            "tamago324/cmp-zsh",

            -- Icons / Emojis
            "hrsh7th/cmp-emoji",
            "chrisgrieser/cmp-nerdfont",
            "max397574/cmp-greek",
            "kdheepak/cmp-latex-symbols",
            "Arkissa/cmp-agda-symbols",

            -- AI
            "tzachar/cmp-ai",
            "vappolinario/cmp-clippy",
            { "tzachar/cmp-tabnine", build = './install.sh', },
            "hrsh7th/cmp-copilot",
            {
                "zbirenbaum/copilot-cmp",
                event = { "InsertEnter", "LspAttach" },
                fix_pairs = true,
            },
            "Exafunction/codeium.nvim",
            "sourcegraph/sg.nvim",
            "luozhiya/fittencode.nvim",
            "supermaven-inc/supermaven-nvim",
            "milanglacier/minuet-ai.nvim",

            -- CSS / Colors / Fonts
            "jcha0713/cmp-tw2css",
            "nat-418/cmp-color-names.nvim",
            "garyhurtz/cmp_bulma.nvim",
            "amarakon/nvim-cmp-fonts",
            "Jezda1337/nvim-html-css",
            "cmp-scss",
            "pontusk/cmp-sass-variables",
            "roginfarrer/cmp-css-variables",

            -- Dependencies
            "Saecki/crates.nvim",
            "David-Kunz/cmp-npm",
            "vrslev/cmp-pypi",
            "Snikimonkd/cmp-go-pkgs",
            "Yu-Leo/cmp-go-pkgs",
            "srv-meta/buck-vim-plugin",

            -- Writing / Notes
            "micangl/cmp-vimtex",
            "nvim-orgmode/orgmode",
            "pontusk/cmp-vimwiki-tags",
            "epwalsh/obsidian.nvim",
            "jc-doyle/cmp-pandoc-references",
            "aspeddro/cmp-pandoc.nvim",
            "Praczet/yaml-tags",

            -- Rails
            "wassimk/cmp-rails-fixture-names",
            "wassimk/cmp-rails-fixture-types",
        },
        opts = {},
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        -- Choose your snippet engine here:
                        vim.fn["vsnip#anonymous"](args.body) -- vsnip
                        -- require("luasnip").lsp_expand(args.body) -- luasnip
                        -- require("snippy").expand_snippet(args.body) -- snippy
                        -- vim.fn["UltiSnips#Anon"](args.body) -- ultisnips
                        -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
                        -- insert({ body = args.body }) -- mini.snippets
                    end,
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" }, -- order of displayed fields

                    format = { require('lspkind').cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = '...',
                        show_labelDetails = true,
                        symbol_map = {
                            HF = "",
                            OpenAI = "",
                            Codestral = "",
                            Bard = "",
                        }
                    })
                    },
                    {
                        function(entry, vim_item)
                            local highlights_info = require("colorful-menu").cmp_highlights(entry)

                            -- highlight_info is nil means we are missing the ts parser, it's
                            -- better to fallback to use default `vim_item.abbr`. What this plugin
                            -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                            if highlights_info ~= nil then
                                vim_item.abbr_hl_group = highlights_info.highlights
                                vim_item.abbr = highlights_info.text
                            end

                            return vim_item
                        end,
                    },
                    {
                        function(entry, vim_item)
                            -- Add nice icons for completion kinds
                            local kind_icons = {
                                Text = "",
                                Method = "",
                                Function = "",
                                Constructor = "",
                                Field = "",
                                Variable = "",
                                Class = "ﴯ",
                                Interface = "",
                                Module = "",
                                Property = "ﰠ",
                                Unit = "",
                                Value = "",
                                Enum = "",
                                Keyword = "",
                                Snippet = "",
                                Color = "",
                                File = "",
                                Reference = "",
                                Folder = "",
                                EnumMember = "",
                                Constant = "",
                                Struct = "",
                                Event = "",
                                Operator = "",
                                TypeParameter = "",
                            }

                            vim_item.kind = kind_icons[vim_item.kind] or vim_item.kind
                            vim_item.menu = ({
                                buffer = "[Buf]",
                                nvim_lsp = "[LSP]",
                                luasnip = "[Snip]",
                                path = "[Path]",
                            })[entry.source.name]

                            return vim_item
                        end,
                    },
                    {
                        function(entry, vim_item)
                            local kind = require("lspkind").cmp_format({
                                mode = "symbol_text",
                            })(entry, vim.deepcopy(vim_item))
                            local highlights_info = require("colorful-menu").cmp_highlights(entry)

                            -- highlight_info is nil means we are missing the ts parser, it's
                            -- better to fallback to use default `vim_item.abbr`. What this plugin
                            -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                            if highlights_info ~= nil then
                                vim_item.abbr_hl_group = highlights_info.highlights
                                vim_item.abbr = highlights_info.text
                            end
                            local strings = vim.split(kind.kind, "%s", { trimempty = true })
                            vim_item.kind = " " .. (strings[1] or "") .. " "
                            vim_item.menu = ""

                            return vim_item
                        end,
                    }
                },
                window = {
                    completion = cmp.config.window.bordered(),    -- adds borders to completion menu
                    documentation = cmp.config.window.bordered(), -- adds borders to docs popup
                },

                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.scopes, --this is commented in nvim-cmp too
                        cmp.config.compare.exact,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.kind,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },

                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(
                        function(fallback)
                            cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
                        end,
                        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
                    ),
                    ["<S-Tab>"] = cmp.mapping(
                        function(fallback)
                            cmp_ultisnips_mappings.jump_backwards(fallback)
                        end,
                        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
                    ),
                    ['<C-x>'] = cmp.mapping(
                        cmp.mapping.complete({
                            config = {
                                sources = cmp.config.sources({
                                    { name = 'cmp_ai' },
                                }),
                            },
                        }),
                        { 'i' }
                    ),
                }),
                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'calc' },
                    { name = 'git' },
                    { name = 'buffer' },
                    { name = 'omni' },
                    { name = 'color_names' },
                    { name = "nvim_lsp" },
                    { name = "vsnip" }, -- or luasnip/snippy/ultisnips/mini.snippets
                    { name = "cmp-sign" },
                    { name = "cmp-luasnip-choice" },
                    { name = "cmp-mini-snippets" },
                    { name = "cmp-neosnippet" },
                    { name = "cmp-snippy" },
                    { name = "cmp-nvim-ultisnips" },
                    { name = "cmp-tsnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "async_path" },
                    { name = "git" },
                    { name = "conventionalcommits" },
                    { name = "commit" },
                    { name = "gitmoji" },
                    { name = "emoji" },
                    { name = "nerdfont" },
                    { name = "greek" },
                    { name = 'ecolog' },
                    {
                        name = "latex_symbols",
                        option = {
                            strategy = 0, -- mixed
                        },
                    },
                    { name = "agda-symbols" },
                    { name = "dictionary" },
                    { name = "spell" },
                    { name = "calc" },
                    { name = "rpncalc" },
                    { name = "fuzzy_buffer" },
                    { name = "fuzzy_path" },
                    { name = "rg" },
                    { name = "fish",        option = { fish_path = "/usr/bin/fish" } },
                    {
                        name = "kitty",
                        option = {

                            -- cmp configuration
                            trigger_characters = {},
                            trigger_characters_ft = {},
                            keyword_pattern = [[\w\+]],

                            -- what information to collect

                            --- words
                            match_words = true,
                            match_upper_case = false,
                            match_lower_case = false,
                            match_capitalized = false,
                            match_alphanumerics = true,
                            match_camel_case = true,
                            match_kebab_case = true,
                            match_snake_case = true,
                            match_dot_case = true,
                            match_words_with_punctuation = true,

                            --- numbers
                            match_integers = true,
                            match_floats = true,
                            match_hex_strings = true,
                            match_binary_strings = true,

                            --- computing
                            match_emails = true,
                            match_ip_addrs = true,
                            match_uuids = true,
                            match_aws_unique_id = false,

                            --- paths
                            match_urls = { "https?" },
                            match_directories = true,
                            match_files = true,
                            match_files_by_suffix = {},
                            match_hidden_files = true,

                            -- window matching configuration
                            os_window = {

                                include_focused = true,
                                include_unfocused = true,

                                include_active = true,
                                include_inactive = true,

                                tab = {

                                    include_active = true,
                                    include_inactive = true,

                                    include_title = function() end,
                                    exclude_title = function() end,

                                    window = {

                                        include_focused = true,
                                        include_unfocused = true,

                                        include_active = true,
                                        include_inactive = true,

                                        include_title = function() end,
                                        exclude_title = function() end,

                                        include_cwd = function() end,
                                        exclude_cwd = function() end,

                                        include_env = function() end,
                                        exclude_env = function() end,

                                        include_foreground_process = function() end,
                                        exclude_foreground_process = function() end,
                                    },
                                },
                            },

                            extent = "all",

                            strict_matching = true,

                            -- Timing configuration
                            window_polling_period = 100,      -- in msec
                            completion_min_update_period = 5, -- in seconds
                            completion_item_lifetime = 60,    -- in seconds
                        }
                    },
                    { name = "nushell" },
                    {
                        name = "tmux",
                        option = {
                            -- Source from all panes in session instead of adjacent panes
                            all_panes = false,

                            -- Completion popup label
                            label = '[tmux]',

                            -- Trigger character
                            trigger_characters = { '.' },

                            -- Specify trigger characters for filetype(s)
                            -- { filetype = { '.' } }
                            trigger_characters_ft = {},

                            -- Keyword patch mattern
                            keyword_pattern = [[\w\+]],

                            -- Capture full pane history
                            -- `false`: show completion suggestion from text in the visible pane (default)
                            -- `true`: show completion suggestion from text starting from the beginning of the pane history.
                            --         This works by passing `-S -` flag to `tmux capture-pane` command. See `man tmux` for details.
                            capture_history = false,
                        }
                    },
                    { name = "zsh" },
                    { name = "cmp-ai" },
                    {
                        name = "cmp-clippy",
                        options = {
                            model = "EleutherAI/gpt-neo-2.7B", -- check code clippy vscode repo for options
                            key = "",                          -- huggingface.co api key
                        }
                    },
                    { name = "cmp-tabnine" },
                    { name = "copilot" },
                    { name = "copilot_cmp" },
                    { name = "codeium" },
                    { name = "sg" },
                    { name = "fittencode" },
                    { name = "supermaven" },
                    { name = "minuet-ai" },
                    { name = "tw2css" },
                    { name = "color_names" },
                    { name = "bulma" },
                    { name = "fonts" },
                    { name = "nvim-html-css" },
                    { name = "cmp-scss" },
                    { name = "cmp-sass-variables" },
                    { name = "cmp-css-variables" },
                    { name = "crates" },
                    { name = "npm" },
                    { name = "pypi" },
                    { name = "cmp-go-pkgs" },
                    { name = "buck-vim-plugin" },
                    { name = "cmp-vimtex" },
                    { name = "orgmode" },
                    { name = "cmp-vimwiki-tags" },
                    { name = "obsidian" },
                    { name = "cmp-pandoc-references" },
                    { name = "cmp-pandoc" },
                    { name = "yaml-tags" },
                    { name = "rails-fixture-names" },
                    { name = "rails-fixture-types" },
                    {
                        name = "diag-codes",
                        -- default completion available only in comment context
                        -- use false if you want to get in other context
                        option = { in_comment = true }
                    },
                }),
            })

            -- Cmdline completion
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } }
            })
            -- Cmdline completion
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    {
                        name = 'path',
                        option = {
                            pathMappings = {
                                ['@'] = '${folder}/src',
                                -- ['/'] = '${folder}/src/public/',
                                -- ['~@'] = '${folder}/src',
                                -- ['/images'] = '${folder}/src/images',
                                -- ['/components'] = '${folder}/src/components',
                            },
                        },
                    },
                    { name = "async_path" },
                }, {
                    { name = "cmdline" },
                    { name = "cmp-cmdline-history" },
                    { name = "cmp-cmdline-prompt" },
                }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })



            require('cmp_sign').setup({
                good = "xxx{{name}}xxxx{{sign}}",
            })

            require('cmp_luasnip_choice').setup({
                auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
            });

            require("cmp_nvim_ultisnips").setup {
                filetype_source = "ultisnips_default",
                show_snippets = "all",
                documentation = function(snippet)
                    return snippet.description .. "\n\n" .. snippet.value
                end
            }

            require("cmp_dictionary").setup({
                paths = { "/usr/share/dict/words" },
                exact_length = 2,
            })


            local format = require("cmp_git.format")
            local sort = require("cmp_git.sort")

            require("cmp_git").setup({
                -- defaults
                filetypes = { "gitcommit", "octo", "NeogitCommitMessage" },
                remotes = { "upstream", "origin" }, -- in order of most to least prioritized
                enableRemoteUrlRewrites = false,    -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
                git = {
                    commits = {
                        limit = 100,
                        sort_by = sort.git.commits,
                        format = format.git.commits,
                        sha_length = 7,
                    },
                },
                github = {
                    hosts = {}, -- list of private instances of github
                    issues = {
                        fields = { "title", "number", "body", "updatedAt", "state" },
                        filter = "all", -- assigned, created, mentioned, subscribed, all, repos
                        limit = 100,
                        state = "open", -- open, closed, all
                        sort_by = sort.github.issues,
                        format = format.github.issues,
                    },
                    mentions = {
                        limit = 100,
                        sort_by = sort.github.mentions,
                        format = format.github.mentions,
                    },
                    pull_requests = {
                        fields = { "title", "number", "body", "updatedAt", "state" },
                        limit = 100,
                        state = "open", -- open, closed, merged, all
                        sort_by = sort.github.pull_requests,
                        format = format.github.pull_requests,
                    },
                },
                gitlab = {
                    hosts = {}, -- list of private instances of gitlab
                    issues = {
                        limit = 100,
                        state = "opened", -- opened, closed, all
                        sort_by = sort.gitlab.issues,
                        format = format.gitlab.issues,
                    },
                    mentions = {
                        limit = 100,
                        sort_by = sort.gitlab.mentions,
                        format = format.gitlab.mentions,
                    },
                    merge_requests = {
                        limit = 100,
                        state = "opened", -- opened, closed, locked, merged
                        sort_by = sort.gitlab.merge_requests,
                        format = format.gitlab.merge_requests,
                    },
                },
                trigger_actions = {
                    {
                        debug_name = "git_commits",
                        trigger_character = ":",
                        action = function(sources, trigger_char, callback, params, git_info)
                            return sources.git:get_commits(callback, params, trigger_char)
                        end,
                    },
                    {
                        debug_name = "gitlab_issues",
                        trigger_character = "#",
                        action = function(sources, trigger_char, callback, params, git_info)
                            return sources.gitlab:get_issues(callback, git_info, trigger_char)
                        end,
                    },
                    {
                        debug_name = "gitlab_mentions",
                        trigger_character = "@",
                        action = function(sources, trigger_char, callback, params, git_info)
                            return sources.gitlab:get_mentions(callback, git_info, trigger_char)
                        end,
                    },
                    {
                        debug_name = "gitlab_mrs",
                        trigger_character = "!",
                        action = function(sources, trigger_char, callback, params, git_info)
                            return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
                        end,
                    },
                    {
                        debug_name = "github_issues_and_pr",
                        trigger_character = "#",
                        action = function(sources, trigger_char, callback, params, git_info)
                            return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
                        end,
                    },
                    {
                        debug_name = "github_mentions",
                        trigger_character = "@",
                        action = function(sources, trigger_char, callback, params, git_info)
                            return sources.github:get_mentions(callback, git_info, trigger_char)
                        end,
                    },
                },
            }
            )

            require('cmp_commit').setup({
                set = true,
                format = { "<<= ", " =>>" },
                length = 9,
                block = { "__pycache__", "CMakeFiles", "node_modules", "target" },
                word_list = "~/cmpcommit.json",
                repo_list = {
                    { "Name of repo", "PATH/TO/FILE.json" }
                }
            })

            require("gitmoji").setup({
                { -- the values below are the defaults
                    filetypes = { "gitcommit" },
                    completion = {
                        append_space = false,
                        complete_as = "emoji",
                    },
                }
            })

            local compare = require('cmp.config.compare')

            cmp.setup {
                sorting = {
                    priority_weight = 2,
                    require("copilot_cmp.comparators").prioritize,
                    comparators = {
                        require('cmp_fuzzy_buffer.compare'),
                        compare.offset,
                        compare.exact,
                        compare.score,
                        compare.recently_used,
                        compare.kind,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                    }
                },
            }

            local cmp_ai = require('cmp_ai.config')

            cmp_ai:setup({
                max_lines = 1000,
                provider = 'OpenAI',
                provider_options = {
                    model = 'gpt-4',
                },
                log_errors = true,
                max_timeout_seconds = 8,
                html = true,
                notify = true,
                notify_callback = function(msg)
                    vim.notify(msg)
                end,
                run_on_every_keystroke = true,
                ignored_file_types = {
                    -- default is not to ignore
                    -- uncomment to ignore in lua:
                    -- lua = true
                },
            })


            local tabnine = require('cmp_tabnine.config')

            tabnine:setup({
                max_lines = 1000,
                max_num_results = 20,
                sort = true,
                run_on_every_keystroke = true,
                snippet_placeholder = '..',
                ignored_file_types = {
                    -- default is not to ignore
                    -- uncomment to ignore in lua:
                    -- lua = true
                },
                show_prediction_strength = false,
                min_percent = 0
            })
            require('cmp_tabnine'):prefetch(file_path)

            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })


            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
            end
            cmp.setup({
                mapping = {
                    ["<Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end),
                },
            })


            -- LSP capabilities
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            -- Example servers (extend as needed)
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.tsserver.setup({ capabilities = capabilities })
            lspconfig.gopls.setup({ capabilities = capabilities })
            lspconfig.rust_analyzer.setup({ capabilities = capabilities })
            lspconfig.html.setup({ capabilities = capabilities })
            lspconfig.cssls.setup({ capabilities = capabilities })
            lspconfig.jsonls.setup({ capabilities = capabilities })
            lspconfig.yamlls.setup({ capabilities = capabilities })


            local handlers = require('nvim-autopairs.completion.handlers')

            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done({
                    filetypes = {
                        -- "*" is a alias to all filetypes
                        ["*"] = {
                            ["("] = {
                                kind = {
                                    cmp.lsp.CompletionItemKind.Function,
                                    cmp.lsp.CompletionItemKind.Method,
                                },
                                handler = handlers["*"]
                            }
                        },
                        lua = {
                            ["("] = {
                                kind = {
                                    cmp.lsp.CompletionItemKind.Function,
                                    cmp.lsp.CompletionItemKind.Method
                                },
                                ---@param char string
                                ---@param item table item completion
                                ---@param bufnr number buffer number
                                ---@param rules table
                                ---@param commit_character table<string>
                                handler = function(char, item, bufnr, rules, commit_character)
                                    -- Your handler function. Inspect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                                end
                            }
                        },
                        -- Disable for tex
                        tex = false
                    }
                })
            )
        end,
    },
}
