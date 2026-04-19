return {
  "mahyarmirrashed/famous-quotes.nvim",
  config = function()
    require("famous-quotes").setup()
    -- Get one random quote (default)
    -- local quote = require('famous-quotes').get_quote()
    -- print(quote[1].author ': ' .. quote[1].quote)

    -- Get three random quotes
    local quotes = require('famous-quotes').get_quote(3)
    -- Get all quotes
    -- local all_quotes = require('famous-quotes').get_quote(-1)
    for _, q in ipairs(quotes) do
      print(q.author .. ': ' .. q.quote)
    end
  end,
}
