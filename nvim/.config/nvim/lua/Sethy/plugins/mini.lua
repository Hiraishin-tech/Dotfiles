return {
    -- Mini Nvim
    { "echasnovski/mini.nvim", version = false },
    -- Comments
    {
        'echasnovski/mini.comment',
        version = false,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            -- disable the autocommand from ts-context-commentstring
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }

            require("mini.comment").setup {
                -- tsx, jsx, html , svelte comment support
                options = {
                    custom_commentstring = function()
                        -- For commenting support in latte files
                        if vim.bo.filetype == 'latte' or vim.bo.filetype == 'latte.php.html' then
                            return '{* %s *}'
                        end
                        return require('ts_context_commentstring.internal').calculate_commentstring({
                                key =
                                'commentstring'
                            })
                            or vim.bo.commentstring
                    end,
                },
            }
        end
    },
    -- File explorer (this works properly with oil unlike nvim-tree)
    {
        "echasnovski/mini.files",
        config = function()
            local MiniFiles = require("mini.files")
            MiniFiles.setup({
                windows = {
                    preview = false,
                },
                mappings = {
                    go_in = "<CR>", -- Map both Enter and L to enter directories or open files
                    go_in_plus = "L",
                    go_out = "-",
                    go_out_plus = "H",
                },
            })

            -- Sdílená proměnná pro telescope smart_live_grep
            _G.last_mini_dir = nil

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesCursorMoved",
                callback = function()
                    local entry = MiniFiles.get_fs_entry()
                    if not entry then return end

                    local path = entry.path
                    local stat = vim.uv.fs_stat(path)
                    if stat and stat.type == "file" then
                        path = vim.fn.fnamemodify(path, ":h")
                    end
                    _G.last_mini_dir = path
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    vim.keymap.set("n", "<leader>fg", function()
                        local entry = MiniFiles.get_fs_entry()
                        if not entry then
                            MiniFiles.close()
                            require("telescope.builtin").live_grep()
                            return
                        end

                        local path = entry.path
                        local stat = vim.uv.fs_stat(path)
                        if stat and stat.type == "file" then
                            path = vim.fn.fnamemodify(path, ":h")
                        end
                        _G.last_mini_dir = path
                        MiniFiles.close()
                        require("telescope.builtin").live_grep({ search_dirs = { path } })
                    end, { buffer = args.data.buf_id, desc = "Live grep in current dir" })

                    vim.keymap.set("n", "<leader>fl", function()
                        local entry = MiniFiles.get_fs_entry()
                        if not entry then
                            MiniFiles.close()
                            require("snacks").picker.files()
                            return
                        end

                        local path = entry.path
                        local stat = vim.uv.fs_stat(path)
                        if stat and stat.type == "file" then
                            path = vim.fn.fnamemodify(path, ":h")
                        end

                        MiniFiles.close()
                        require("snacks").picker.files({ cwd = path })
                    end, { buffer = args.data.buf_id, desc = "Find files in current dir (Snacks)" })
                end,
            })

            vim.keymap.set("n", "<leader>ex", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" }) -- toggle file explorer
            vim.keymap.set("n", "<leader>ef", function()
                MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
                MiniFiles.reveal_cwd()
            end, { desc = "Toggle into currently opened file" })
        end,
    },
    --- Surround
    {
        "echasnovski/mini.surround",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('mini.surround').setup({
                -- Add custom surroundings to be used on top of builtin ones. For more
                -- information with examples, see `:h MiniSurround.config`.
                custom_surroundings = nil,
                -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
                highlight_duration = 300,
                -- Module mappings. Use `''` (empty string) to disable one.
                -- INFO:
                -- ysiw(ys), saiw(sa) surround inner word with no whitespace
                -- ysaw(ys), saaw(sa) surround a word with whitespace
                -- yss_ surround entire line
                mappings = {
                    add = 'gys',          -- Add surrounding in Normal and Visual modes (added g to avoid input lag for 's')
                    delete = 'ds',       -- Delete surrounding
                    find = '',           -- Disable find
                    find_left = '',      -- Disable find left
                    highlight = '',      -- Disable highlight
                    replace = 'cs',      -- Replace surrounding
                    update_n_lines = '', -- Disable update_n_lines
                    suffix_last = 'l',   -- Suffix to search with "prev" method
                    suffix_next = 'n',   -- Suffix to search with "next" method
                },
                -- Number of lines within which surrounding is searched
                n_lines = 20,
                -- Whether to respect selection type:
                -- - Place surroundings on separate lines in linewise mode.
                -- - Place surroundings on each line in blockwise mode.
                respect_selection_type = false,
                -- How to search for surrounding (first inside current line, then inside
                -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
                -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
                -- see `:h MiniSurround.config`.
                search_method = 'cover',
                -- Whether to disable showing non-error feedback
                silent = false,
            })

            -- Restore default 's' behavior (substitute character)
            vim.keymap.set('n', 's', 'cl', { noremap = true, desc = 'Substitute character' })
        end,
    },
    -- Get rid of whitespace
    {
        "echasnovski/mini.trailspace",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local miniTrailspace = require("mini.trailspace")

            miniTrailspace.setup({
                only_in_normal_buffers = true,
            })
            vim.keymap.set("n", "<leader>cw", function() miniTrailspace.trim() end, { desc = "Erase Whitespace" })

            -- Ensure highlight never reappears by removing it on CursorMoved
            vim.api.nvim_create_autocmd("CursorMoved", {
                pattern = "*",
                callback = function()
                    require("mini.trailspace").unhighlight()
                end,
            })
        end,
    },
    -- Split & join
    {
        "echasnovski/mini.splitjoin",
        config = function()
            local miniSplitJoin = require("mini.splitjoin")
            miniSplitJoin.setup({
                mappings = { toggle = "" }, -- Disable default mapping
            })
            vim.keymap.set({ "n", "x" }, "<leader>sj", function() miniSplitJoin.join() end, { desc = "Join arguments" })
            vim.keymap.set({ "n", "x" }, "<leader>sk", function() miniSplitJoin.split() end, { desc = "Split arguments" })
        end,
    },
}
