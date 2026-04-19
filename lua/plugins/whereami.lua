return {
    "ragnarok22/whereami.nvim",
    cmd = "Whereami",
    dependencies = {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
            local whereami = require("whereami")
            -- set keymaps
            vim.keymap.set("n", "<leader>l", whereami.country, { desc = "Show the country" })
            vim.keymap.set("n", "<leader>e", whereami.city, { desc = "Show the city" })
            vim.keymap.set("n", "<leader>i", whereami.ip, { desc = "Show the ip" })
            vim.keymap.set("n", "<leader>s", whereami.isp, { desc = "Show the ISP" })
            
        end
    }
}
