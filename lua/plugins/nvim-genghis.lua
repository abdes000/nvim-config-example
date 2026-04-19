return {
    "chrisgrieser/nvim-genghis",
    keys = {
        -- File creation & duplication
        { "<leader>fn", "<cmd>CreateNewFile<cr>",             desc = "FileOps: Create new file (same dir)" },
        { "<leader>ff", "<cmd>CreateNewFileInFolder<cr>",     desc = "FileOps: Create new file in folder" },
        { "<leader>fd", "<cmd>DuplicateFile<cr>",             desc = "FileOps: Duplicate current file" },
        { "<leader>fm", "<cmd>MoveSelectionToNewFile<cr>",    desc = "FileOps: Move selection to new file" },

        -- File movement & renaming
        { "<leader>fr", "<cmd>RenameFile<cr>",                desc = "FileOps: Rename current file" },
        { "<leader>fo", "<cmd>MoveToFolderInCwd<cr>",         desc = "FileOps: Move file to folder in cwd" },
        { "<leader>fR", "<cmd>MoveAndRenameFile<cr>",         desc = "FileOps: Move and rename file" },

        -- File permissions & deletion
        { "<leader>fx", "<cmd>Chmodx<cr>",                    desc = "FileOps: Make file executable (+x)" },
        { "<leader>ft", "<cmd>TrashFile<cr>",                 desc = "FileOps: Move file to trash" },
        { "<leader>fe", "<cmd>ShowInSystemExplorer<cr>",      desc = "FileOps: Reveal file in system explorer" },

        -- Copy operations
        { "<leader>cf", "<cmd>CopyFilename<cr>",              desc = "FileOps: Copy filename" },
        { "<leader>cp", "<cmd>CopyFilepath<cr>",              desc = "FileOps: Copy absolute filepath" },
        { "<leader>c~", "<cmd>CopyFilepathWithTilde<cr>",     desc = "FileOps: Copy filepath with ~" },
        { "<leader>cr", "<cmd>CopyRelativePath<cr>",          desc = "FileOps: Copy relative filepath" },
        { "<leader>cd", "<cmd>CopyDirectoryPath<cr>",         desc = "FileOps: Copy absolute directory path" },
        { "<leader>cD", "<cmd>CopyRelativeDirectoryPath<cr>", desc = "FileOps: Copy relative directory path" },
        { "<leader>ci", "<cmd>CopyFileItself<cr>",            desc = "FileOps: Copy file itself (macOS only)" },
    },

    config = function()
        -- default config
        require("genghis").setup {
            input = { enabled = true },
            picker = { enabled = true },
            fileOperations = {
                -- automatically keep the extension when no file extension is given
                -- (everything after the first non-leading dot is treated as the extension)
                autoAddExt = true,

                trashCmd = function() ---@type fun(): string|string[]
                    if jit.os == "OSX" then return "trash" end -- builtin since macOS 14
                    if jit.os == "Windows" then return "trash" end
                    if jit.os == "Linux" then return { "gio", "trash" } end
                    return "trash-cli"
                end,

                ignoreInFolderSelection = { -- using lua pattern matching (e.g., escape `-` as `%-`)
                    "/node_modules/",       -- nodejs
                    "/typings/",            -- python
                    "/doc/",                -- vim help files folders
                    "%.app/",               -- macOS pseudo-folders
                    "/%.",                  -- hidden folders
                },
            },

            navigation = {
                onlySameExtAsCurrentFile = false,
                ignoreDotfiles = true,
                ignoreExt = { "png", "svg", "webp", "jpg", "jpeg", "gif", "pdf", "zip" },
                ignoreFilesWithName = { ".DS_Store" },
            },

            successNotifications = true,

            icons = { -- set an icon to empty string to disable it
                chmodx = "󰒃",
                copyFile = "󱉥",
                copyPath = "󰅍",
                duplicate = "",
                file = "󰈔",
                move = "󰪹",
                new = "󰝒",
                nextFile = "󰖽",
                prevFile = "󰖿",
                rename = "󰑕",
                trash = "󰩹",
            },
        }
    end
}
