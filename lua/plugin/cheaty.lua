return {
    "stikypiston/cheaty.nvim",
    opts = {},
    config = function()
        require("cheaty").setup({
            width      = 0.6,
            height     = 0.6,
            save_file  = vim.fs.joinpath(vim.fn.stdpath("data"), "cheaty.md"),
            cheatsheet = {
                "# This is a sample cheatsheet!",
                "Customise it by editing *this buffer* (just press `i`)",
                "Or in the `cheatsheet` section of the config!"
            }
        })
    end
}
