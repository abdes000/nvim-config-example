return {
    "neo451/feed.nvim",
    cmd = "Feed",
    ---@module 'feed'
    ---@type feed.config
    opts = {},
    config = function()
        require("feed").setup({
            rsshub = {
                instance = "127.0.0.1:1200",   -- or any public instance listed here https://rsshub.netlify.app/instances
                export = "https://rsshub.app", -- used in export_opml
            },
            feeds = {
                -- These two styles both work
                "https://neovim.io/news.xml",
                {
                    "https://neovim.io/news.xml",
                    name = "Neovim News",
                    tags = { "tech", "news" }, -- tags given are inherited by all its entries
                },

                -- the above is equivalent to:
                news = {
                    tech = {
                        { "https://neovim.io/news.xml", name = "Neovim News" },
                    },
                },

                -- three link formats are supported:
                "https://neovim.io/news.xml",                  -- Regular links
                "rsshub://rsshub://apnews/topics/apf-topnews", -- RSSHub links
                "neovim/neovim/releases",                      -- GitHub links
            },
            ui = {
                tags = {
                    color = "String",
                    format = function(id, db)
                        local icons = {
                            news = "📰",
                            tech = "💻",
                            movies = "🎬",
                            games = "🎮",
                            music = "🎵",
                            podcast = "🎧",
                            books = "📚",
                            unread = "🆕",
                            read = "✅",
                            junk = "🚮",
                            star = "⭐",
                        }

                        local get_icon = function(name)
                            if icons[name] then
                                return icons[name]
                            end
                            local has_mini, MiniIcons = pcall(require, "mini.icons")
                            if has_mini then
                                local icon = MiniIcons.get("filetype", name)
                                if icon then
                                    return icon .. " "
                                end
                            end
                            return name
                        end

                        local tags = vim.tbl_map(get_icon, db:get_tags(id))
                        table.sort(tags)
                        return "[" .. table.concat(tags, ", ") .. "]"
                    end,
                },
                rder = { "date", "feed", "tags", "title", "reading_time" },
                reading_time = {
                    color = "Comment",
                    format = function(id, db)
                        local cpm = 1000                -- set to whatever you like
                        local content = db:get(id):gsub("%s+", " ") -- reads the entry content
                        local chars = vim.fn.strchars(content)
                        local time = math.ceil(chars / cpm)
                        return string.format("(%s min)", time)
                    end,
                },
            },
        })
        local function play_podcast()
            local link = require("feed").get_entry().link
            if link:find("mp3") then
                vim.ui.open(link)
                -- any other player like:
                -- vim.system({ "vlc.exe", link })
            else
                vim.notify("not a podcast episode")
            end
        end

        local function show_in_w3m()
            if not vim.fn.executable("w3m") then
                vim.notify("w3m not installed")
                return
            end
            local link = require("feed").get_entry().link
            local w3m = require("feed.ui.window").new({
                relative = "editor",
                col = math.floor(vim.o.columns * 0.1),
                row = math.floor(vim.o.lines * 0.1),
                width = math.floor(vim.o.columns * 0.8),
                height = math.floor(vim.o.lines * 0.8),
                border = "rounded",
                style = "minimal",
                title = "Feed w3m",
                zindex = 10,
            })
            vim.keymap.set({ "n", "t" }, "q", "<cmd>q<cr>", { silent = true, buffer = w3m.buf })
            vim.fn.jobstart({ "w3m", link }, { term = true })
            vim.cmd("startinsert")
        end

        require("feed").setup({
            keys = {
                index = {
                    { "p", play_podcast },
                    { "w", show_in_w3m },
                },
            },
        })

        local og_color
        local og_background

        vim.api.nvim_create_autocmd("User", {
            pattern = "FeedShowIndex",
            callback = function()
                if not og_color then
                    og_color = vim.g.colors_name
                end
                if not og_background then
                    og_background = vim.opt.background
                end
                vim.cmd.colorscheme("e-ink")
                vim.opt.background = "light"
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "FeedQuitIndex",
            callback = function()
                vim.cmd.colorscheme(og_color)
                vim.opt.background = og_background
            end,
        })
    end
}
