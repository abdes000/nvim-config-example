return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",

        -- Core extensions
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

        -- Productivity
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-project.nvim",
        "nvim-telescope/telescope-recent-files.nvim",
        "nvim-telescope/telescope-frecency.nvim",
        "nvim-telescope/telescope-session.nvim",
        "nvim-telescope/telescope-undo.nvim",
        "nvim-telescope/telescope-command-palette.nvim",
        "nvim-telescope/telescope-tabs",
        "nvim-telescope/telescope-tele-tabby.nvim",
        "nvim-telescope/telescope-windowizer.nvim",
        "nvim-telescope/telescope-menu.nvim",
        "nvim-telescope/telescope-tasks.nvim",

        -- Git
        "nvim-telescope/telescope-git-branch.nvim",
        "nvim-telescope/telescope-git-grep.nvim",
        "nvim-telescope/telescope-git-selector.nvim",
        "nvim-telescope/telescope-gitmoji.nvim",
        "nvim-telescope/telescope-cc.nvim",
        "nvim-telescope/telescope-git-conflicts",
        "nvim-telescope/telescope-git-submodules.nvim",
        "nvim-telescope/telescope-git-diffs.nvim",

        -- Fun / Symbols
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-emoji.nvim",
        "nvim-telescope/telescope-glyph.nvim",
        "nvim-telescope/telescope-color-names.nvim",
        "nvim-telescope/telescope-box-drawing.nvim",
        "nvim-telescope/telescope-heading.nvim",
        "nvim-telescope/telescope-ports.nvim",
        "nvim-telescope/telescope-http-codes.nvim",

        -- Language / Dev
        "nvim-telescope/telescope-lsp-handlers.nvim",
        "nvim-telescope/telescope-ctags-outline.nvim",
        "nvim-telescope/telescope-terraform-doc.nvim",
        "nvim-telescope/telescope-ros.nvim",
        "nvim-telescope/telescope_hoogle",
        "nvim-telescope/telescope-gott.nvim",
        "nvim-telescope/telescope-switch.nvim",
        "nvim-telescope/telescope-rails.nvim",
        "nvim-telescope/telescope-texsuite",
        "nvim-telescope/telescope-just.nvim",
        "nvim-telescope/telescope-zotero.nvim",
        "nvim-telescope/telescope-foldmarkers.nvim",
        "nvim-telescope/telescope-jj.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-rg.nvim",
        "nvim-telescope/telescope-hierarchy.nvim",

        -- Integrations
        "nvim-telescope/telescope-github.nvim",
        "nvim-telescope/telescope-ghq.nvim",
        "nvim-telescope/telescope-repo.nvim",
        "nvim-telescope/telescope-node-modules.nvim",
        "nvim-telescope/telescope-z.nvim",
        "nvim-telescope/telescope-tmuxinator.nvim",
        "nvim-telescope/telescope-hop.nvim",
        "nvim-telescope/telescope-docker.nvim",
        "nvim-telescope/telescope-docker-commands",
        "nvim-telescope/telescope-openbrowser.nvim",
        "nvim-telescope/telescope-vim-bookmarks.nvim",
        "nvim-telescope/telescope-tmux.nvim",
        "nvim-telescope/telescope-zoxide",
        "nvim-telescope/telescope-luasnip.nvim",
        "nvim-telescope/telescope-lazy.nvim",
        "nvim-telescope/telescope-lazy-plugins.nvim",
        "nvim-telescope/telescope-cscope.nvim",
        "nvim-telescope/telescope-vimspector.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "nvim-telescope/telescope-dapzzzz",
        "nvim-telescope/telescope-packer.nvim",
        "nvim-telescope/telescope-asynctasks.nvim",
        "nvim-telescope/telescope-ultisnips.nvim",
        "nvim-telescope/telescope-coc.nvim",
        "nvim-telescope/telescope-resession.nvim",
        "nvim-telescope/telescope-gpt.nvim",
        "nvim-telescope/telescope-cmdline.nvim",
        "nvim-telescope/telescope-cmdline-word.nvim",
        "nvim-telescope/telescope-everything.nvim",
        "nvim-telescope/telescope-extension-maker.nvim",
        "nvim-telescope/ad-telescope-extensions.nvim",
        "nvim-telescope/telescope-alternate",
        "nvim-telescope/telescope-search-dir-picker.nvim",
        "nvim-telescope/telescope-directory.nvim",
        "nvim-telescope/dir-telescope.nvim",
        "nvim-telescope/telescope-monorepos.nvim",
        "nvim-telescope/telescope-filelinks.nvim",
        "nvim-telescope/telescope-import.nvim",
        "nvim-telescope/telescope-picker-list.nvim",
        "nvim-telescope/telescope-cache",
        "nvim-telescope/telescope-find-exe.nvim",
        "nvim-telescope/telescope-changes.nvim",
        "nvim-telescope/telescope-scriptnames.nvim",
        "nvim-telescope/telescope-messages.nvim",
        "nvim-telescope/telescope-helpgrep.nvim",
        "nvim-telescope/telescope-manix",
        "nvim-telescope/telescope-opds",
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-tele-tabby.nvim",
        "nvim-telescope/telescope-tabs",
        "nvim-telescope/telescope-undo.nvim",
        "nvim-telescope/telescope-ctags-outline.nvim",
        "nvim-telescope/telescope-terraform-doc.nvim",
        "nvim-telescope/telescope-rails.nvim",
        "nvim-telescope/telescope-texsuite",
        "nvim-telescope/telescope-just.nvim",
        "nvim-telescope/telescope-zotero.nvim",
        "nvim-telescope/telescope-foldmarkers.nvim",
        "nvim-telescope/telescope-jj.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-rg.nvim",
        "nvim-telescope/telescope-hierarchy.nvim",
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({})

        -- Dynamically load all extensions
        local extensions = {
            "fzf", "file_browser", "project", "recent_files", "frecency", "session",
            "undo", "command_palette", "tabs", "tele_tabby", "windowizer", "menu",
            "git_branch", "git_grep", "git_selector", "gitmoji", "cc", "git_conflicts",
            "git_submodules", "git_diffs", "symbols", "emoji", "glyph", "color_names",
            "box_drawing", "heading", "ports", "http_codes", "lsp_handlers", "ctags_outline",
            "terraform_doc", "ros", "hoogle", "gott", "switch", "rails", "texsuite", "just",
            "zotero", "foldmarkers", "jj", "live_grep_args", "rg", "hierarchy", "github",
            "ghq", "repo", "node_modules", "z", "tmuxinator", "hop", "docker", "docker_commands",
            "openbrowser", "vim_bookmarks", "tmux", "zoxide", "luasnip", "lazy", "lazy_plugins",
            "cscope", "vimspector", "dap", "dapzzzz", "packer", "asynctasks", "ultisnips", "coc",
            "resession", "gpt", "cmdline", "cmdline_word", "everything", "extension_maker",
            "alternate", "search_dir_picker", "directory", "dir_telescope", "monorepos",
            "filelinks", "import", "picker_list", "cache", "find_exe", "changes", "scriptnames",
            "messages", "helpgrep", "manix", "opds"
        }

        for _, ext in ipairs(extensions) do
            pcall(telescope.load_extension, ext)
        end

        require 'telescope-all-recent'.setup {
            database = {
                folder = vim.fn.stdpath("data"),
                file = "telescope-all-recent.sqlite3",
                max_timestamps = 10,
            },
            debug = false,
            scoring = {
                recency_modifier = {                   -- also see telescope-frecency for these settings
                    [1] = { age = 240, value = 100 },  -- past 4 hours
                    [2] = { age = 1440, value = 80 },  -- past day
                    [3] = { age = 4320, value = 60 },  -- past 3 days
                    [4] = { age = 10080, value = 40 }, -- past week
                    [5] = { age = 43200, value = 20 }, -- past month
                    [6] = { age = 129600, value = 10 } -- past 90 days
                },
                -- how much the score of a recent item will be improved.
                boost_factor = 0.0001
            },
            default = {
                disable = true,    -- disable any unkown pickers (recommended)
                use_cwd = true,    -- differentiate scoring for each picker based on cwd
                sorting = 'recent' -- sorting: options: 'recent' and 'frecency'
            },
            pickers = {            -- allows you to overwrite the default settings for each picker
                man_pages = {      -- enable man_pages picker. Disable cwd and use frecency sorting.
                    disable = false,
                    use_cwd = false,
                    sorting = 'frecency',
                },

                -- change settings for a telescope extension.
                -- To find out about extensions, you can use `print(vim.inspect(require'telescope'.extensions))`
                ['extension_name#extension_method'] = {
                    -- [...]
                }
            }
        }
        require("telescope").register_extension("echo")
        local telescope = require('telescope')
        telescope.setup {
            extensions = {
                doodle = {} -- Enable the doodle extension
            }
        }
        -- Load the extension
        telescope.load_extension('doodle')

        -- Example keymaps for doodle's telescope pickers
        local keymap = vim.keymap.set
        keymap("n", "<space>dd", function()
            telescope.extensions.doodle.find_notes()
        end, { desc = "Doodle Find Notes" })

        keymap("n", "<space>ff", function()
            telescope.extensions.doodle.find_files()
        end, { desc = "Doodle Find Files" })

        keymap("n", "<space>dy", function()
            telescope.extensions.doodle.find_templates()
        end, { desc = "Doodle Find Templates" })

        require("telescope").load_extension("package_info")
        require("telescope").load_extension("lazygit")
        require("telescope").load_extension("yank_history")
        require("telescope").load_extension("undo")
        -- =========================
        -- Keymaps (Grouped)
        -- =========================
        local map = vim.keymap.set

        -- Productivity
        map("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "File browser" })
        map("n", "<leader>fp", ":Telescope project<CR>", { desc = "Projects" })
        map("n", "<leader>fr", ":Telescope recent_files pick<CR>", { desc = "Recent files" })
        map("n", "<leader>fe", ":Telescope frecency<CR>", { desc = "Frecency files" })
        map("n", "<leader>fu", ":Telescope undo<CR>", { desc = "Undo history" })
        map("n", "<leader>fc", ":Telescope command_palette<CR>", { desc = "Command palette" })
        map("n", "<leader>ft", ":Telescope tabs<CR>", { desc = "Tabs" })

        -- Git
        map("n", "<leader>gb", ":Telescope git_branch<CR>", { desc = "Git branches" })
        map("n", "<leader>gg", ":Telescope git_grep<CR>", { desc = "Git grep" })
        map("n", "<leader>gw", ":Telescope git_selector<CR>", { desc = "Git worktrees" })
        map("n", "<leader>gm", ":Telescope gitmoji<CR>", { desc = "Gitmoji commits" })
        map("n", "<leader>gc", ":Telescope cc<CR>", { desc = "Conventional commits" })

        -- Fun / Symbols
        map("n", "<leader>se", ":Telescope emoji<CR>", { desc = "Emoji picker" })
        map("n", "<leader>sg", ":Telescope glyph<CR>", { desc = "Glyph picker" })
        map("n", "<leader>sc", ":Telescope color_names<CR>", { desc = "Color names" })
        -- Fun / Symbols (continued)
        map("n", "<leader>sb", ":Telescope box_drawing<CR>", { desc = "Box drawing chars" })
        map("n", "<leader>sh", ":Telescope heading<CR>", { desc = "Document headings" })
        map("n", "<leader>ss", ":Telescope symbols<CR>", { desc = "Insert symbols" })
        map("n", "<leader>shc", ":Telescope http_codes<CR>", { desc = "HTTP codes" })

        -- Media
        map("n", "<leader>sm", ":Telescope media_files<CR>", { desc = "Media files" })

        -- LSP / Dev
        map("n", "<leader>ll", ":Telescope lsp_handlers<CR>", { desc = "LSP handlers" })
        map("n", "<leader>lo", ":Telescope ctags_outline<CR>", { desc = "CTags outline" })
        map("n", "<leader>lt", ":Telescope terraform_doc<CR>", { desc = "Terraform docs" })
        map("n", "<leader>lr", ":Telescope ros<CR>", { desc = "ROS packages" })
        map("n", "<leader>lh", ":Telescope hoogle<CR>", { desc = "Haskell Hoogle search" })
        map("n", "<leader>lg", ":Telescope gott<CR>", { desc = "Go tests" })
        map("n", "<leader>lsw", ":Telescope switch<CR>", { desc = "Switch files" })
        map("n", "<leader>lR", ":Telescope rails<CR>", { desc = "Rails navigation" })
        map("n", "<leader>lT", ":Telescope texsuite<CR>", { desc = "LaTeX menus" })
        map("n", "<leader>lj", ":Telescope just<CR>", { desc = "Justfile tasks" })
        map("n", "<leader>lz", ":Telescope zotero<CR>", { desc = "Zotero picker" })
        map("n", "<leader>lf", ":Telescope foldmarkers<CR>", { desc = "Fold markers" })
        map("n", "<leader>ljj", ":Telescope jj<CR>", { desc = "Jujutsu repos" })
        map("n", "<leader>lga", ":Telescope live_grep_args<CR>", { desc = "Live grep args" })
        map("n", "<leader>lrg", ":Telescope rg<CR>", { desc = "Custom rg grep" })
        map("n", "<leader>lhh", ":Telescope hierarchy<CR>", { desc = "Code hierarchy" })

        -- Integrations
        map("n", "<leader>gh", ":Telescope github issues<CR>", { desc = "GitHub issues" })
        map("n", "<leader>gP", ":Telescope github pull_requests<CR>", { desc = "GitHub PRs" })
        map("n", "<leader>gr", ":Telescope repo<CR>", { desc = "Repositories" })
        map("n", "<leader>gn", ":Telescope node_modules list<CR>", { desc = "Node modules" })
        map("n", "<leader>gz", ":Telescope zoxide list<CR>", { desc = "Zoxide dirs" })
        map("n", "<leader>gt", ":Telescope tmux sessions<CR>", { desc = "Tmux sessions" })
        map("n", "<leader>gd", ":Telescope docker containers<CR>", { desc = "Docker containers" })
        map("n", "<leader>gD", ":Telescope docker_commands<CR>", { desc = "Docker commands" })
        map("n", "<leader>go", ":Telescope openbrowser<CR>", { desc = "Open browser bookmarks" })
        map("n", "<leader>gbm", ":Telescope vim_bookmarks<CR>", { desc = "Vim bookmarks" })
        map("n", "<leader>gl", ":Telescope luasnip<CR>", { desc = "LuaSnip snippets" })
        map("n", "<leader>gy", ":Telescope yank_history<CR>", { desc = "Yank history (neoclip)" })
        map("n", "<leader>gp", ":Telescope packer<CR>", { desc = "Packer plugins" })
        map("n", "<leader>ga", ":Telescope asynctasks<CR>", { desc = "Async tasks" })
        map("n", "<leader>gcoc", ":Telescope coc<CR>", { desc = "Coc.nvim integration" })
        map("n", "<leader>grs", ":Telescope resession<CR>", { desc = "Resession sessions" })
        map("n", "<leader>ggpt", ":Telescope gpt<CR>", { desc = "ChatGPT integration" })
        map("n", "<leader>gcs", ":Telescope cscope<CR>", { desc = "Cscope picker" })
        map("n", "<leader>gdap", ":Telescope dap<CR>", { desc = "DAP integration" })
        map("n", "<leader>gdzz", ":Telescope dapzzzz<CR>", { desc = "DAP configs" })
        map("n", "<leader>gv", ":Telescope vimspector<CR>", { desc = "Vimspector integration" })
        map("n", "<leader>glz", ":Telescope lazy<CR>", { desc = "Lazy plugins" })
        map("n", "<leader>glp", ":Telescope lazy_plugins<CR>", { desc = "Lazy plugin configs" })
        map("n", "<leader>gex", ":Telescope everything<CR>", { desc = "Everything integration" })
        map("n", "<leader>gim", ":Telescope import<CR>", { desc = "Import modules" })
        map("n", "<leader>gpl", ":Telescope picker_list<CR>", { desc = "List all pickers" })
        map("n", "<leader>gch", ":Telescope changes<CR>", { desc = "Changes history" })
        map("n", "<leader>gsn", ":Telescope scriptnames<CR>", { desc = "Scriptnames" })
        map("n", "<leader>gms", ":Telescope messages<CR>", { desc = "Messages" })
        map("n", "<leader>ghg", ":Telescope helpgrep<CR>", { desc = "Help grep" })
        map("n", "<leader>gmn", ":Telescope manix<CR>", { desc = "Nix docs" })
        map("n", "<leader>gop", ":Telescope opds<CR>", { desc = "OPDS catalogs" })
    end,
}
