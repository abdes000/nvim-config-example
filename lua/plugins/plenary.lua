return {
    "nvim-lua/plenary.nvim",
    config = function()
        local Job = require 'plenary.job'

        Job:new({
            command = 'rg',
            args = { '--files' },
            cwd = '/usr/bin',
            env = { ['a'] = 'b' },
            on_exit = function(j, return_val)
                print(return_val)
                print(j:result())
            end,
        }):sync() -- or start()
        local scan = require 'plenary.scandir'
        scan.scan_dir('.', { hidden = true, depth = 2 })
    end
}
