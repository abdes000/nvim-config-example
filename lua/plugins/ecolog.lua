return {
    'ph1losof/ecolog.nvim',
    branch = 'beta',
    -- Optional: you can add some keybindings
    -- (I personally use lspsaga so check out lspsaga integration or lsp integration for a smoother experience without separate keybindings)
    keys = {
        -- Peek & refresh
        { "<leader>ep",  "<cmd>EcologPeek<cr>",                desc = "Ecolog: Peek env var under cursor" },
        { "<leader>eP",  "<cmd>EcologPeek ",                   desc = "Ecolog: Peek env var (prompt)" },
        { "<leader>er",  "<cmd>EcologRefresh<cr>",             desc = "Ecolog: Refresh env cache" },

        -- File selection & navigation
        { "<leader>es",  "<cmd>EcologSelect<cr>",              desc = "Ecolog: Select env file" },
        { "<leader>eS",  "<cmd>EcologSelect ",                 desc = "Ecolog: Load specific env file" },
        { "<leader>eg",  "<cmd>EcologGoto<cr>",                desc = "Ecolog: Open selected env file" },
        { "<leader>ev",  "<cmd>EcologGotoVar<cr>",             desc = "Ecolog: Go to variable definition" },
        { "<leader>eV",  "<cmd>EcologGotoVar ",                desc = "Ecolog: Go to specific variable" },

        -- Shelter mode
        { "<leader>et",  "<cmd>EcologShelterToggle<cr>",       desc = "Ecolog: Toggle shelter mode" },
        { "<leader>el",  "<cmd>EcologShelterLinePeek<cr>",     desc = "Ecolog: Reveal value on current line" },

        -- Pickers (Telescope, fzf, snacks)
        { "<leader>eT",  "<cmd>EcologTelescope<cr>",           desc = "Ecolog: Telescope picker" },
        { "<leader>ef",  "<cmd>EcologFzf<cr>",                 desc = "Ecolog: fzf-lua picker" },
        { "<leader>en",  "<cmd>EcologSnacks<cr>",              desc = "Ecolog: snacks.nvim picker" },

        -- Env get/set
        { "<leader>egv", "<cmd>EcologEnvGet<cr>",              desc = "Ecolog: Get env var value" },
        { "<leader>esv", "<cmd>EcologEnvSet<cr>",              desc = "Ecolog: Set env var value" },

        -- Copy values
        { "<leader>ec",  "<cmd>EcologCopy<cr>",                desc = "Ecolog: Copy env var under cursor" },
        { "<leader>eC",  "<cmd>EcologCopy ",                   desc = "Ecolog: Copy specific env var" },

        -- Config menus
        { "<leader>ea",  "<cmd>EcologAWSConfig<cr>",           desc = "Ecolog: AWS Secrets Manager config" },
        { "<leader>evc", "<cmd>EcologVaultConfig<cr>",         desc = "Ecolog: HCP Vault config" },

        -- Toggles
        { "<leader>ei",  "<cmd>EcologInterpolationToggle<cr>", desc = "Ecolog: Toggle interpolation" },
        { "<leader>esh", "<cmd>EcologShellToggle<cr>",         desc = "Ecolog: Toggle shell variables" },
    },

    -- Lazy loading is done internally
    lazy = false,
    opts = {
        integrations = {
            -- WARNING: for both cmp integrations see readme section below
            nvim_cmp = true, -- If you dont plan to use nvim_cmp set to false, enabled by default
            -- If you are planning to use blink cmp uncomment this line
            -- blink_cmp = true,
            omnifunc = true,
            lsp = true,
            lspsaga = true,
            statusline = {
                hidden_mode = false, -- Hide when no env file is loaded
                icons = {
                    enabled = true, -- Enable icons in statusline
                    env = "🌲", -- Icon for environment file
                    shelter = "🛡️", -- Icon for shelter mode
                },

                format = {
                    env_file = function(name)
                        return name -- Format environment file name
                    end,
                    vars_count = function(count)
                        return string.format("%d vars", count) -- Format variables count
                    end,
                },
                highlights = {
                    enabled = true,         -- Enable custom highlights
                    env_file = "Directory", -- Highlight group for file name
                    vars_count = "Number",  -- Highlight group for vars count
                    icons = "Special"
                },
            }
        },
        sources = {
            { name = 'ecolog' },
            -- your other sources...
        },
        -- Enables shelter mode for sensitive values
        shelter = {
            configuration = {
                -- Partial mode configuration:
                -- false: completely mask values (default)
                -- true: use default partial masking settings
                -- table: customize partial masking
                -- partial_mode = false,
                -- or with custom settings:
                partial_mode = {
                    show_start = 3,    -- Show first 3 characters
                    show_end = 3,      -- Show last 3 characters
                    min_mask = 3,      -- Minimum masked characters
                },
                mask_char = "*",       -- Character used for masking
                mask_length = nil,     -- Optional: fixed length for masked portion (defaults to value length)
                skip_comments = false, -- Skip masking comment lines in environment files (default: false)
            },
            modules = {
                cmp = true,                  -- Enabled to mask values in completion
                peek = false,                -- Enable to mask values in peek view
                files = true,                -- Enabled to mask values in file buffers
                telescope = false,           -- Enable to mask values in telescope integration
                telescope_previewer = false, -- Enable to mask values in telescope preview buffers
                fzf = false,                 -- Enable to mask values in fzf picker
                fzf_previewer = false,       -- Enable to mask values in fzf preview buffers
                snacks_previewer = false,    -- Enable to mask values in snacks previewer
                snacks = false,              -- Enable to mask values in snacks picker
            }
        },
        -- true by default, enables built-in types (database_url, url, etc.)
        types = true,
        path = vim.fn.getcwd(),                -- Path to search for .env files
        preferred_environment = "development", -- Optional: prioritize specific env files
        -- Controls how environment variables are extracted from code and how cmp works
        provider_patterns = true,
        interpolation = {
            enabled = true,            -- Enable/disable interpolation
            max_iterations = 10,       -- Maximum iterations for nested interpolation
            warn_on_undefined = true,  -- Warn about undefined variables
            fail_on_cmd_error = false, -- How to handle command substitution errors
            disable_security = false,  -- Disable security sanitization for command substitution
            features = {
                variables = true,      -- Enable variable interpolation ($VAR, ${VAR})
                defaults = true,       -- Enable default value syntax (${VAR:-default})
                alternates = true,     -- Enable alternate value syntax (${VAR-alternate})
                commands = true,       -- Enable command substitution ($(command))
                escapes = true,        -- Enable escape sequences (\n, \t, etc.)
            }
        },                             -- true by default, when false will not check provider patterns
        monorepo = {
            enabled = true,
            auto_switch = true,
            notify_on_switch = false, -- Show notifications when switching workspaces

            -- Provider configuration
            providers = {
                -- Built-in providers (loaded automatically)
                builtin = {
                    "turborepo",
                    "nx",
                    "lerna",
                    "yarn_workspaces",
                    "cargo_workspaces"
                },
                -- Custom providers
                custom = {
                    {
                        module = "my_custom_provider",
                        config = { custom_option = "value" }
                    }
                }
            },

            -- Performance settings
            performance = {
                -- Cache configuration
                cache = {
                    max_entries = 1000,
                    default_ttl = 300000,    -- 5 minutes
                    cleanup_interval = 60000 -- 1 minute
                },

                -- Auto-switch throttling
                auto_switch_throttle = {
                    min_interval = 100,             -- Minimum ms between checks
                    debounce_delay = 250,           -- Debounce delay for rapid changes
                    same_file_skip = true,          -- Skip if same file
                    workspace_boundary_only = true, -- Only check when crossing boundaries
                    max_checks_per_second = 10      -- Rate limiting
                }
            }
        },
        vim_env = true, -- false by default
        sort_file_fn = function(a, b)
            -- Sort by file size (smaller files first)
            local a_size = vim.fn.getfsize(a)
            local b_size = vim.fn.getfsize(b)
            return a_size < b_size
        end,
        custom_types = {
            semver = {
                pattern = "^v?%d+%.%d+%.%d+%-?[%w]*$",
                validate = function(value)
                    local major, minor, patch = value:match("^v?(%d+)%.(%d+)%.(%d+)")
                    return major and minor and patch
                end,
            },
            aws_region = {
                pattern = "^[a-z]{2}%-[a-z]+%-[0-9]$",
                validate = function(value)
                    local valid_regions = {
                        ["us-east-1"] = true,
                        ["us-west-2"] = true,
                        -- ... etc
                    }
                    return valid_regions[value] == true
                end
            }
        },
        types = {
            -- Built-in types
            url = true,          -- URLs (http/https)
            localhost = true,    -- Localhost URLs
            ipv4 = true,         -- IPv4 addresses
            database_url = true, -- Database connection strings
            number = true,       -- Integers and decimals
            boolean = true,      -- true/false/yes/no/1/0
            json = true,         -- JSON objects and arrays
            iso_date = true,     -- ISO 8601 dates (YYYY-MM-DD)
            iso_time = true,     -- ISO 8601 times (HH:MM:SS)
            hex_color = true,    -- Hex color codes (#RGB or #RRGGBB)
        }
    },
}
