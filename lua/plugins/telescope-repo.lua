return {
    'cljoly/telescope-repo.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require("telescope").setup {
            extensions = {
                repo = {
                    list = {
                        fd_opts = {
                            "--no-ignore-vcs",
                        },
                        search_dirs = {
                            "~/my_projects",
                        },
                    },
                },
            },
        }

        require("telescope").load_extension "repo"
    end
}
