return {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
        enabled = true,
        commented = true,  -- show virtual text as comments
        virt_text_pos = "eol", -- end of line
    },
}
