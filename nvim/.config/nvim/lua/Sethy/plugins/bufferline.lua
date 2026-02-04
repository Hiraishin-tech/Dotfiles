return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function ()
            require('bufferline').setup({
                options = {
                    -- more info on :h bufferline.nvim
                    diagnostics = "nvim_lsp",
                    mode = "tabs", -- set to "buffers"(show buffers :ls), tabs" to only show tabpages instead
                    separator_style = "slant", -- | "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
                    show_buffer_icons = true, -- (false) disable filetype icons for buffers
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    buffer_close_icon = '󰅖',
                    modified_icon = '● ',
                    close_icon = ' ',
                }
            })
        end
    }
}
