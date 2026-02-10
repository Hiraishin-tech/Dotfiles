return {
    "CRAG666/betterTerm.nvim",
    config = function ()
        local betterTerm = require('betterTerm')

        -- Toggle the first terminal (ID defaults to index_base, which is 0)
        vim.keymap.set({"n", "t"}, "<M-f>", function() betterTerm.open() end, { desc = "Toggle terminal" })

        -- Open a specific terminal
        vim.keymap.set({"n", "t"}, "<C-/>", function() betterTerm.open(1) end, { desc = "Toggle terminal 1" })

        -- Cycle to the right
        vim.keymap.set({"n", "t"}, "<C-l>", function() betterTerm.cycle(1) end, { desc = "Cycle terminals to the right" })

        -- Cycle to the left
        vim.keymap.set({"n", "t"}, "<C-h>", function() betterTerm.cycle(-1) end, { desc = "Cycle terminals to the left" })

        -- Select a terminal to focus
        vim.keymap.set("n", "<leader>tt", betterTerm.select, { desc = "Select terminal" })

        -- Rename the current terminal
        vim.keymap.set("n", "<leader>tr", betterTerm.rename, { desc = "Rename terminal" })

        -- Toggle the tabs bar
        vim.keymap.set("n", "<leader>tb", betterTerm.toggle_tabs, { desc = "Toggle terminal tabs" })

        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "In terminal mode press escape to enter normal mode" })

        -- Move out of terminal like normal windows
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Go up"} )
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Go down"} )

        -- ⬆⬇ horizontal resize
        vim.keymap.set("t", "<C-Up>", [[<C-\><C-n>:resize +2<CR>i]], { desc = "Bigger terminal window"} )
        vim.keymap.set("t", "<C-Down>", [[<C-\><C-n>:resize -2<CR>i]], { desc = "Smaller terminal window"} )

        -- Example configuration
        require('betterTerm').setup {
            prefix = "Term",
            position = "bot",
            size = math.floor(vim.o.lines/ 2),
            startInserted = true,
            show_tabs = true,
            new_tab_mapping = "<C-t>",
            jump_tab_mapping = "<C-$tab>",
            active_tab_hl = "TabLineSel",
            inactive_tab_hl = "TabLine",
            new_tab_hl = "BetterTermSymbol",
            new_tab_icon = "+",
            index_base = 0,
            predefined = {},
            -- predefined = {
            --     { index = 0, name = "Main" },
            --     { index = 1, name = "Server" },
            --     { index = 2, name = "Tests" },
            -- },
        }
    end
}
