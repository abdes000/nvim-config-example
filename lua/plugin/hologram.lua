return {
    'edluffy/hologram.nvim',
    config = function ()
        Image:new(source, {
    format = 100, -- format in which image data is sent
    transmission_type = 'f', -- transmission medium used
    data_width = nil, -- px. width of image
    data_height = nil, -- px. height of image
    data_size = nil, -- size of data to read from file
    data_offset = nil, -- offset from which to read file data
    image_number = nil, -- image number
    compressed = nil, -- whether data is compressed or not
    image_id = nil, -- image id
    placement_id = 1, -- placement id
})
Image:display(row, col, buf, {
    x_offset = nil, -- left edge of image area to start displaying from (px.)
    y_offset = nil, -- top edge of image area to start displaying from (px.)
    width = nil, -- width of image area to display
    height = nil, -- height of image area to display
    cell_x = nil, -- x-offset within first cell to start displaying from (px.)
    cell_y = nil, -- y-offset within first cell to start displaying from (px.)
    cols = nil, -- number of columns to display over
    rows = nil, -- number of rows to display over
    z_index = 0, -- vertical stacking order of image
    placement_id = 1, -- placement id
})
-- Image:delete(id, {
--     free = false -- when deleting image, free stored image data and also extmark of image. (default: false)
-- })
vim.defer_fn(function()
    Image:delete(0, {free = true})
end, 5000)
    end
}