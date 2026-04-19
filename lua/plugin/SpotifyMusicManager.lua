return {
    'iamt4nk/smm.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = {
        premium = true,
        icons = true, -- Whether to use nerdfonts

        -- debug = true,                    -- These can be used in case there are any issues and you need to debug.
        -- file = '/tmp/smm_debug.log'

        playback = {
            timer_update_interval = 250,  -- How often the timer itself is  updated in ms
            timer_sync_interval = 5000,   -- How often sync requests are sent to the server in ms
            playback_pos = 'BottomRight', -- Options { 'TopLeft', 'TopRight', 'BottomLeft', 'BottomRight' }
            playback_width = 40,          -- Width of the playback window
            progress_bar_width = 35,      -- Width of the progress bar
        },

        spotify = {
            api_retry_max = 3, -- The number of times to retry before failing out.
            api_retry_backoff = 2000,
            auth = {           -- These are the only absolutely required configurations.
                client_id = '<your client id>',
                callback_url = '<your callback URL>',
                callback_port = '<your callback port>',
            },
        },
    },
    keys = {
        { "<leader>spa",   "<cmd>Spotify auth<cr>",          desc = "Spotify: Re-authenticate" },
        { "<leader>spp",   "<cmd>Spotify pause<cr>",         desc = "Spotify: Pause" },
        { "<leader>spr",   "<cmd>Spotify resume<cr>",        desc = "Spotify: Resume" },
        { "<leader>spn",   "<cmd>Spotify next<cr>",          desc = "Spotify: Next track" },
        { "<leader>sppv",  "<cmd>Spotify prev<cr>",          desc = "Spotify: Previous track" },
        { "<leader>sps",   "<cmd>Spotify shuffle<cr>",       desc = "Spotify: Toggle shuffle" },
        { "<leader>sprp",  "<cmd>Spotify repeat<cr>",        desc = "Spotify: Repeat context" },
        { "<leader>sprt",  "<cmd>Spotify repeat track<cr>",  desc = "Spotify: Repeat track" },
        { "<leader>spro",  "<cmd>Spotify repeat off<cr>",    desc = "Spotify: Repeat off" },

        -- Playback from queries
        { "<leader>sppl",  "<cmd>Spotify play liked<cr>",    desc = "Spotify: Play liked songs" },
        { "<leader>spplq", "<cmd>Spotify play playlist ",    desc = "Spotify: Play playlist (query)" },
        { "<leader>sppla", "<cmd>Spotify play album ",       desc = "Spotify: Play album (query)" },
        { "<leader>sppls", "<cmd>Spotify play song ",        desc = "Spotify: Play song (query)" },
        { "<leader>spplr", "<cmd>Spotify play artist ",      desc = "Spotify: Play artist (query)" },

        -- Liking/unliking
        { "<leader>spli",  "<cmd>Spotify like_song<cr>",     desc = "Spotify: Like current song" },
        { "<leader>splu",  "<cmd>Spotify unlike_song<cr>",   desc = "Spotify: Unlike current song" },

        -- Device selection
        { "<leader>spd",   "<cmd>Spotify select device<cr>", desc = "Spotify: Select device" },
    },
}
