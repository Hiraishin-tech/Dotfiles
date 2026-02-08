return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        -- NOTE: in the toggleterm terminal I can scroll by Ctrl + \ Ctrl + n then moving like in VIM hjkl, ctrl + u/d. Or by using mouse
        keys = {
            -- { "<C-/>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
            -- { "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle terminal", mode = { "n", "t" } },  -- leader+tt
            {
                -- "<leader>tt", -- When I am in the terminal there is a problem that when I do space there is a input lag due to neovim waiting after space.
                "<A-t>", -- Alt + t 
                function()
                    -- Directory of the current file
                    local dir = vim.fn.expand("%:p:h")

                    -- fallback if there is no file buffer
                    if dir == "" or vim.fn.isdirectory(dir) == 0 then
                        dir = vim.fn.getcwd()
                    end

                    vim.cmd(
                        "ToggleTerm direction=horizontal dir="
                        .. vim.fn.fnameescape(dir)
                    )
                end,
                desc = "Toggle terminal (file dir)",
                mode = { "n", "t" },
            },
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
            -- { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Horizontal" },
            -- { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal Vertical" },
        },
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return 10
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            -- open_mapping = [[<leader>tt]],  -- Ctrl+` pro toggle (jako VSCode)
            autochdir = false,
            hide_numbers = true,
            shading_factor = 3, -- default is -30
            shading_ratio = 5, -- default is -5
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true, -- mapování funguje i v insert módu
            terminal_mappings = true,
            persist_size = true,
            persist_mode = true,
            direction = "horizontal", -- default: float, horizontal, vertical, tab
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved", -- single, double, shadow, curved
                winblend = 0,
            },
            on_open = function(term)
                -- resize keymaps just for ToggleTerm buffer
                -- resize keymaps JUST pro ToggleTerm buffer
                local opts = { noremap = true, silent = true, buffer = term.bufnr }

                -- Move out of terminal like normal windows
                vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
                vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
                vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
                vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

                -- Pressing escape key to exit the terminal mode and enter normal mode
                vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

                -- ⬆⬇ horizontal resize
                vim.keymap.set(
                    "t",
                    "<C-Up>",
                    [[<C-\><C-n>:resize +2<CR>i]],
                    opts
                )
                vim.keymap.set(
                    "t",
                    "<C-Down>",
                    [[<C-\><C-n>:resize -2<CR>i]],
                    opts
                )

                -- start v insertu
                vim.cmd("startinsert!")
            end,
            highlights = {
                Normal = {
                    guibg = "#0a0a0a",  -- darker background
                },
                NormalFloat = {
                    guibg = "#0a0a0a",
                },
                FloatBorder = {
                    guifg = "#444444",
                    guibg = "#0a0a0a",
                },
            },
        },
    }
}
