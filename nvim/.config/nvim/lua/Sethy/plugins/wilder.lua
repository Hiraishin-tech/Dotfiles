return {
    "gelguy/wilder.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "romgrk/fzy-lua-native",
    },

    config = function()
        local wilder = require ("wilder")
        wilder.setup({
            modes = {":", "/", "?" },
        })

        -- Tab pro výběr
        vim.keymap.set('c', '<Tab>', function()
            return wilder.in_context() and wilder.next() or '<Tab>'
        end, { expr = true })

        -- Shift-Tab pro předchozí
        vim.keymap.set('c', '<S-Tab>', function()
            return wilder.in_context() and wilder.previous() or '<S-Tab>'
        end, { expr = true }) -- expr = true calls the function and uses it's return value

        -- Ctrl-j/k alternativa
        vim.keymap.set('c', '<C-j>', wilder.next)
        vim.keymap.set('c', '<C-k>', wilder.previous)

        -- Enter pro potvrzení
        vim.keymap.set('c', '<CR>', '<CR>', { expr = false })

        -- Define custom highlight group
        wilder.set_option(
            "renderer",
            wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
                min_width = "20%", -- minimum height of the popupmenu, can also be a number
                max_height = "13%", -- to set a fixed height, set max_height to the same value
                reverse = 0, -- if 1, shows the candidates from bottom to top
                highlighter = {
                    wilder.lua_pcre2_highlighter(), -- Requires luarocks install pcre2
                    wilder.lua_fzy_highlighter(), -- Requires fzy-lua-native
                },
                highlights = {
                    default = wilder.make_hl(
                        "WilderPopupMenu",
                        "Pmenu",
                        { { a = 1 }, { a = 1 }, { background = "#1E212B" } } -- Adjust background color
                    ),
                    accent = wilder.make_hl(
                        "WilderAccent",
                        "Pmenu",
                        { { a = 1 }, { a = 1 }, { foreground = "#58FFD6", background = "#1e1e2e" } }
                    ),
                },
                -- 'single', 'double', 'rounded' or 'solid'
                -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
                border = "rounded",
            }))
        )

    end
}
