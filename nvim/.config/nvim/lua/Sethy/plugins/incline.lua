return {
    -- Adding a filename to the top right
    {
        "b0o/incline.nvim";
        enabled = true, -- change to false to disable
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local devicons = require("nvim-web-devicons")
            local incline = require("incline")

            incline.setup({
                hide = {
                    only_win = false -- shows incline on all windows
                },

                render = function(props)
                    local bufname = vim.api.nvim_buf_get_name(props.buf) -- gets the fullpath of the buffer
                    local filename = vim.fn.fnamemodify(bufname, ":t") -- grabs only the trailing part of the path (so only filename)
                    if filename == '' then filename = '[No Name]' end -- if filename is empty then showcases placeholder

                    local ext = vim.fn.fnamemodify(bufname, ":e") -- gets extension
                    local icon, icon_color = devicons.get_icon(filename, ext, { default = true }) -- if it doesn't know the filetype then gives a default icon

                    local modified = vim.bo[props.buf].modified -- checks if there are unsaved changes

                    -- this returns the whole label:
                    return {
                        { " ", icon, " ", guifg = icon_color },
                        { filename, gui = modified and "bold" or "none" },
                        {modified and { " [+]", guifg = "#ff9e64" }} or "",
                        " ",
                    }
                end
            })
        end
    }
}
