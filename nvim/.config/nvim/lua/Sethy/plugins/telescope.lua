return {
	"nvim-telescope/telescope.nvim",
	branch = "master", -- using master to fix issues with deprecated to definition warnings 
    -- '0.1.x' for stable ver.
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- improves search performance
		"nvim-tree/nvim-web-devicons",
		"andrew-george/telescope-themes",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local previewers = require("telescope.previewers")
        local action_state = require("telescope.actions.state")

		telescope.load_extension("fzf")
		telescope.load_extension("themes")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- moving around in telescope themes by ctrl + k 
						["<C-j>"] = actions.move_selection_next,
					},
				},
			},
			extensions = {
				themes = {
					enable_previewer = true,
					enable_live_preview = true,
					persist = {
						enabled = true,
						path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
					},
				},
			},
		})

        local function tabs_picker()
            local tabs = vim.api.nvim_list_tabpages()
            local results = {}

            for i, tab in ipairs(tabs) do
                local win = vim.api.nvim_tabpage_get_win(tab)
                local buf = vim.api.nvim_win_get_buf(win)
                local full_path = vim.api.nvim_buf_get_name(buf) -- full path for previewer
                -- local name = vim.api.nvim_buf_get_name(buf)
                table.insert(results, {
                    tab = tab,
                    bufnr = buf,
                    index = i,
                    path = full_path, -- saving the path
                    name = full_path ~= "" and vim.fn.fnamemodify(full_path, ":t") or "[No Name]",
                })
            end

            pickers.new({}, {
                prompt_title = "Tabs",
                finder = finders.new_table({
                    results = results,
                    entry_maker = function(entry)
                        return {
                            -- value = entry.tab,
                            -- display = entry.name,
                            value = entry,
                            display = string.format("%d: %s", entry.index, entry.name),
                            ordinal = entry.name,
                            path = entry.path,
                            bufnr = entry.bufnr, -- important for preview
                        }
                    end,
                }),
                sorter = conf.generic_sorter({}),
                -- previewer = previewers.vim_buffer_cat.new({}),
                previewer = conf.file_previewer({}),
                attach_mappings = function(_, map)
                    map("i", "<CR>", function(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        vim.api.nvim_set_current_tabpage(selection.value.tab)
                    end)
                    return true
                end,
            }):find()
        end

		-- Keymaps
		vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
        vim.keymap.set('n', "<leader>fb", builtin.buffers, { desc = "Telescope buffers" }) -- Can also be accessed through :Telescope buffers
        vim.keymap.set('n', "<leader>ft", tabs_picker, { desc = "Telescope tabs" })
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
        end, { desc = "Find Connected Words under cursor" })

		vim.keymap.set("n", "<leader>ths", "<cmd>Telescope themes<CR>", { noremap = true, silent = true, desc = "Theme Switcher" })
    end,
}
