return {
    'melmass/echo.nvim',
    opts = {
        amplify = 0.5, -- the default level of amplification if not provided
        -- (defaults to 1.0)
        demo = false,  -- install the demo events (the ones from the video demo)
        -- custom table of event -> sound mapping)
        events = {
            BufRead = { path = "builtin:EXPAND", amplify = 1.0 },
            BufWrite = { path = "builtin:SUCCESS_2", amplify = 1.0 },
            CursorMovedI = { path = "builtin:BUTTON_3", amplify = 0.45 },
            ExitPre = { path = "builtin:COMPLETE_3", amplify = 1.0 },
            InsertLeave = { path = "builtin:NOTIFICATION_5", amplify = 0.5 },
        }
    },
    confog = function()
        local echo = require("echo")

        -- Play a sound from path
        -- echo.play_sound("/path/to/file.mp3")

        -- Play a sound from the builtins
        echo.play_sound("builtin:SUCCESS_2")
    end
}
